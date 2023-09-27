// Import the UIKit framework
// Almost always going to need this when referencing UI elements in file
import UIKit


// Class declaration, including the name of class and subclass (UIViewController)
class ForecastViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    // displaying multiple forecasts
    private var forecasts = [WeatherForecast]()
    private var selectedForecastIndex = 0
    
    
    // Function override for the view controller
    // This is fired when the view has finished loading for the first time
    override func viewDidLoad() {
        // Some functions require calling the super class implementation
        
        super.viewDidLoad()
        addGradient()
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex])
//        let fakeData = WeatherForecast(weatherCode: .partlyCloudy,
//                                          temperature: 25.0,
//                                                 date: Date())
//           configure(with: fakeData)
         }
    
    private func createMockData() -> [WeatherForecast] {
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
        // mock data
        let mockData1 = WeatherForecast(windSpeed: 3.3,
                                        weatherCode: .violentRainShowers,
                                        precipitation: 33.3,
                                        temperature: 59.5,
                                        date: today)
        let mockData2 = WeatherForecast(windSpeed: 3.7,
                                        weatherCode: .fog,
                                        precipitation: 13.3,
                                        temperature: 65.5,
                                        date: tomorrow)
        let mockData3 = WeatherForecast(windSpeed: 2.8,
                                        weatherCode: .partlyCloudy,
                                        precipitation: 23.3,
                                        temperature: 49.5,
                                        date: dayAfterTomorrow)
        return [mockData1, mockData2, mockData3]
        
    }
    
    
    
     private func configure(with forecast: WeatherForecast) {
       
       forecastImageView.image = forecast.weatherCode.image
       descriptionLabel.text = forecast.weatherCode.description
       temperatureLabel.text = "\(forecast.temperature)°F"
       precipitationLabel.text = "\(forecast.precipitation)%"
       windSpeedLabel.text = "\(forecast.windSpeed) mph"
         
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "MMMM d, yyyy"
       dateLabel.text = dateFormatter.string(from: forecast.date)
     }
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.25, green: 0.5, blue: 0.99, alpha: 1.00).cgColor,
                                UIColor(red: 0.23, green: 0.99, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
