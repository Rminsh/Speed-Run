//
//  SpeedLimiterVC.swift
//  Speed Run
//
//  Created by Armin on 6/1/19.
//  Copyright © 2019 Armin Shalchian. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class SpeedLimiterVC: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let speedLimiters = [
        "Freeway 120 km/h",
        "Highway 100 km/h",
        "Highway 90 km/h",
        "Highway 80 km/h",
        "Highway 70 km/h"]
    let defaults: UserDefaults = UserDefaults.standard
    var audioPlayer: AVAudioPlayer!
    var locationManager = CLLocationManager()
    @IBOutlet weak var warningSwitch: UISwitch!
    @IBOutlet weak var speedMeter: SpeedMeterView!
    @IBOutlet weak var speedPicker: UIPickerView!
    
    @IBOutlet weak var speedLimiterStack: UIStackView!
    @IBOutlet weak var emptyStateLocation: UIStackView!
    
    var playWarning: Bool = false
    var currentSpeedLimit: Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return speedLimiters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return speedLimiters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.set(String(row), forKey: SettingsKeys.speedLimitKey)
        setSpeedLimit(index: row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.speedPicker.dataSource = self
        self.speedPicker.delegate = self
        
        initSpeedMeter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                showLocationEmptyState()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                showSpeedMeter()
                break
            @unknown default:
                print("Location services are not enabled")
            }
        } else {
            emptyStateLocation.isHidden = true
            speedLimiterStack.isHidden = false
        }
    }
    
    func showLocationEmptyState() {
        emptyStateLocation.isHidden = false
        speedLimiterStack.isHidden = true
    }
    
    func initSpeedMeter() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        playWarning = self.defaults.bool(forKey: SettingsKeys.speedWarningKey)
        warningSwitch.isOn = self.defaults.bool(forKey: SettingsKeys.speedWarningKey)
        
        speedPicker.selectRow(self.defaults.integer(forKey: SettingsKeys.speedLimitKey), inComponent:0, animated:true)
        setSpeedLimit(index: self.defaults.integer(forKey: SettingsKeys.speedLimitKey))
        
        let path = Bundle.main.path(forResource: "beep", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func showSpeedMeter() {
        
        locationManager.startUpdatingLocation()
        
        emptyStateLocation.isHidden = true
        speedLimiterStack.isHidden = false
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (speedLimiterStack.isHidden) {
            speedLimiterStack.isHidden = false
            emptyStateLocation.isHidden = true
        }
        
        //Get Current Location
        let location = locations.last! as CLLocation
        
        // For getting speed
        let speed = location.speed * 3.6
        
        // Check High Speed
        if playWarning {
            if (speed >= Double(currentSpeedLimit)) {
                self.speedMeter.setStatus(_status: 1)
                audioPlayer.play()
            } else {
                self.speedMeter.setStatus(_status: 0)
                audioPlayer.stop()
            }
        }
        
        // Set Speed
        if (speed >= 0) {
            self.speedMeter.setSpeed(_speed: CGFloat(speed))
        }
        
        locationManager.startUpdatingHeading()
        
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch (status) {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .denied, .restricted:
            showLocationEmptyState()
            break
        case .authorizedAlways, .authorizedWhenInUse:
            showSpeedMeter()
            break
        default:
            showLocationEmptyState()
            break
        }
    }
    
    @IBAction func openSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
    
    @IBAction func enableSpeedWarningSound(_ sender: UISwitch) {
        
        if sender.isOn {
            defaults.set("true", forKey: SettingsKeys.speedWarningKey)
            self.playWarning = true
        } else {
            defaults.set("false", forKey: SettingsKeys.speedWarningKey)
            self.playWarning = false
            
            self.speedMeter.setStatus(_status: 0)
            audioPlayer.stop()
        }
    }
    
    func setSpeedLimit(index: Int) {
        switch index {
        case 0:
            currentSpeedLimit = 120
            break
        case 1:
            currentSpeedLimit = 100
            break
        case 2:
            currentSpeedLimit = 90
            break
        case 3:
            currentSpeedLimit = 80
            break
        case 4:
            currentSpeedLimit = 70
            break
        default:
            break
        }
    }
}
