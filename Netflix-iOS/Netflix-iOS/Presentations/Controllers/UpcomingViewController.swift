//
//  UpcomingViewController.swift
//  Netflix-iOS
//
//  Created by Seonwoo Kim on 12/26/23.
//

import UIKit
import SnapKit

final class UpcomingViewController: UIViewController {
    
    private let hours: [String] = ["1시간", "2시간", "3시간", "4시간", "5시간", "6시간", "7시간", "8시간"]
    private let minutes: [String] = ["10분", "20분", "30분", "40분", "50분"]
    
    var progressBar: UIProgressView!
    var progress: Float = 0.0
    let pagingVIew = PagingView()
    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("햄토리 파이팅!", for: .normal)
        startButton.addTarget(self, action: #selector(startProgress), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .lightGray
        return startButton
    }()
    
    var hoursLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "시간을 설정"
        textLabel.textColor = .white
        
        return textLabel
    }()
    
    var minutesLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "분을 설정"
        textLabel.textColor = .white
        
        return textLabel
    }()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .lightGray
        picker.delegate = self
        picker.dataSource = self

        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProgressBar()
        setUI()
    }
    
    func setUI() {
        configureProgressBar()  // 이 부분을 앞으로 옮김
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        view.addSubview(progressBar)
        view.addSubview(startButton)
        view.addSubview(pickerView)
        view.addSubview(pagingVIew)
        view.addSubview(hoursLabel)
        view.addSubview(minutesLabel)
    }
    
    func setConstraints() {
        progressBar.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        hoursLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(60)
        }
        
        minutesLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(90)
        }

        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
        }

        pagingVIew.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(progressBar.snp.top).offset(-50)
        }

        pickerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(startButton.snp.bottom).offset(20)
        }
    }
    
    func configureProgressBar() {
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func startProgress() {
        UIView.animate(withDuration: 0.5) {
            self.progress += 0.2
            self.progressBar.setProgress(self.progress, animated: true)
        }
    }
}

extension UpcomingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return hours[row]
            } else {
                return minutes[row]
            }
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                hoursLabel.text = hours[row]
            } else {
                minutesLabel.text = minutes[row]
            }
        }
}
