//
//  WeatherViewModelTests.swift
//  Weather appTests
//
//  Created by Steven Hill on 15/01/2024.
//

import XCTest
@testable import Weather_app
import Combine

final class WeatherViewModelTests: XCTestCase {

    private var mockWeatherViewModel: WeatherViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    private func setUpVMForAPIFailure(with weatherResult: Result<Weather_app.APIResponse, Weather_app.WeatherService.FetchError>, and aqiResult: Result<Weather_app.AirPollutionResponse, Weather_app.WeatherService.FetchError>) -> WeatherViewModel {
        let mockWeatherService = MockWeatherService()
        let mockLocationService = MockLocationService()
        mockWeatherService.weatherResult = weatherResult
        mockWeatherService.aqiResult = aqiResult
        mockWeatherViewModel = WeatherViewModel(weatherService: mockWeatherService, locationService: mockLocationService)
        return mockWeatherViewModel
    }
    
    private func setUpVMForAPISuccess() -> WeatherViewModel {
        let mockWeatherService = MockWeatherService()
        let mockLocationService = MockLocationService()
        let weatherResult = mockWeatherService.readMockWeatherJsonFile()
        let aqiResult = mockWeatherService.readMockAQIJsonFile()
        mockWeatherService.weatherResult = .success(weatherResult)
        mockWeatherService.aqiResult = .success(aqiResult)
        mockWeatherViewModel = WeatherViewModel(weatherService: mockWeatherService, locationService: mockLocationService)
        return mockWeatherViewModel
    }

    override func setUp() {
        super.setUp()
        cancellable = []
    }

    override func tearDown() {
        super.tearDown()
        mockWeatherViewModel = nil
        cancellable = []
    }
    
    func test_WeatherAPI_Failure() {
        let sut = setUpVMForAPIFailure(with: .failure(.missingResponse), and: .failure(.missingResponse))
        sut.getWeather()
        sut.getAirPollution()
        
        XCTAssertTrue(sut.name == "Unknown")
        XCTAssertTrue(sut.hasError)
    }

    func test_AQIAPI_Failure() {
        let sut = setUpVMForAPIFailure(with: .failure(.missingResponse), and: .failure(.missingResponse))
        sut.getWeather()
        sut.getAirPollution()
      
        XCTAssertTrue(sut.hasError)
        XCTAssertTrue(sut.aqiText.isEmpty)
    }
    
    func test_WeatherAPI_Success() {
        let sut = setUpVMForAPISuccess()
        let expectation = XCTestExpectation(description: "Get weather")
        sut.getWeather()
        sut.getAirPollution()
        
        sut
            .$name
            .dropFirst(2)
            .sink { value in
                XCTAssertEqual(sut.name, "Hong Kong")
                XCTAssertEqual(sut.weatherDescription, "overcast clouds")
                XCTAssertTrue(sut.symbol == "cloud.fill")
                XCTAssertEqual(sut.temp, 304.66)
                XCTAssertTrue(sut.errorMessage.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_AQIAPI_Success() {
        let sut = setUpVMForAPISuccess()
        let expectation = XCTestExpectation(description: "Get AQI")
        sut.getWeather()
        sut.getAirPollution()
        
        sut
            .$aqiText
            .dropFirst(2)
            .sink { value in
                XCTAssertEqual(sut.aqiText, "poor")
                XCTAssertTrue(sut.aqiSymbol == "aqi.high")
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
    }
}
