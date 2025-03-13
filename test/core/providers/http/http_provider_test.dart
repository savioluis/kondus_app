import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kondus/core/providers/http/i_http_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpProvider extends Mock implements IHttpProvider {}

class MockResponse extends Mock implements Response {}

void main() async {
  group(
    'GIVEN HttpProvider instance',
    () {
      late MockHttpProvider mockHttpProvider;
      late MockResponse mockResponse;
      const baseUrl = 'https://jsonplaceholder.typicode.com/todos/3';

      setUp(
        () {
          mockHttpProvider = MockHttpProvider();
          mockResponse = MockResponse();
        },
      );

      test(
        'WHEN create HttpProvider instance THEN it should be created with success',
        () {
          expect(mockHttpProvider, isNotNull);
          expect(mockHttpProvider, isA<IHttpProvider>());
        },
      );

      group(
        'WHEN calling GET method',
        () {
          const headers = {'key': 'value'};
          const responseBody = 'Any data here';

          setUp(
            () {
              when(() => mockResponse.statusCode).thenReturn(200);
              when(() => mockResponse.data).thenReturn(responseBody);
              when(() => mockHttpProvider.get(baseUrl, headers: headers))
                  .thenAnswer((_) async => mockResponse);
            },
          );

          test(
            'THEN it should make a GET request and return the correct data',
            () async {
              final response =
                  await mockHttpProvider.get(baseUrl, headers: headers);

              verify(() => mockHttpProvider.get(baseUrl, headers: headers))
                  .called(1);

              expect(response.statusCode, 200);
              expect(response.data, responseBody);
            },
          );
        },
      );

      group(
        'WHEN calling POST method',
        () {
          const headers = {'key': 'value'};
          const requestBody = '{"key": "value"}';
          const responseBody = 'Any data here';

          setUp(() {
            when(() => mockResponse.statusCode).thenReturn(201);
            when(() => mockResponse.data).thenReturn(responseBody);
            when(
              () => mockHttpProvider.post(baseUrl,
                  data: requestBody, headers: headers),
            ).thenAnswer((_) async => mockResponse);
          });

          test(
            'THEN it should make a POST request and return the correct data',
            () async {
              final response = await mockHttpProvider.post(
                baseUrl,
                data: requestBody,
                headers: headers,
              );

              verify(
                () => mockHttpProvider.post(
                  baseUrl,
                  data: requestBody,
                  headers: headers,
                ),
              ).called(1);

              expect(response.statusCode, 201);
              expect(response.data, responseBody);
            },
          );
        },
      );

      group(
        'WHEN calling PUT method',
        () {
          const headers = {'key': 'value'};
          const requestBody = '{"key": "updatedValue"}';
          const responseBody = 'Any data here';

          setUp(() {
            when(() => mockResponse.statusCode).thenReturn(200);
            when(() => mockResponse.data).thenReturn(responseBody);
            when(
              () => mockHttpProvider.put(baseUrl,
                  data: requestBody, headers: headers),
            ).thenAnswer((_) async => mockResponse);
          });

          test(
            'THEN it should make a PUT request and return the correct data',
            () async {
              final response = await mockHttpProvider.put(
                baseUrl,
                data: requestBody,
                headers: headers,
              );

              verify(
                () => mockHttpProvider.put(baseUrl,
                    data: requestBody, headers: headers),
              ).called(1);

              expect(response.statusCode, 200);
              expect(response.data, responseBody);
            },
          );
        },
      );

      group(
        'WHEN calling DELETE method',
        () {
          const headers = {'key': 'value'};

          setUp(() {
            when(() => mockResponse.statusCode).thenReturn(204);
            when(() => mockResponse.data).thenReturn('');
            when(() => mockHttpProvider.delete(baseUrl, headers: headers))
                .thenAnswer((_) async => mockResponse);
          });

          test(
            'THEN it should make a DELETE request and return the correct status code',
            () async {
              final response =
                  await mockHttpProvider.delete(baseUrl, headers: headers);

              verify(() => mockHttpProvider.delete(baseUrl, headers: headers))
                  .called(1);

              expect(response.statusCode, 204);
              expect(response.data, isEmpty);
            },
          );
        },
      );

      group(
        'WHEN an error occurs',
        () {
          const headers = {'key': 'value'};

          setUp(() {
            when(() => mockHttpProvider.get(baseUrl, headers: headers))
                .thenThrow(
              DioException(requestOptions: RequestOptions()),
            );
          });

          test(
            'THEN it should throw an exception',
            () async {
              expect(
                () async =>
                    await mockHttpProvider.get(baseUrl, headers: headers),
                throwsA(isA<DioException>()),
              );
            },
          );
        },
      );
    },
  );
}
