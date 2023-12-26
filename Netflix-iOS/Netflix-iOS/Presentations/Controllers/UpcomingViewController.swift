//
//  UpcomingViewController.swift
//  Netflix-iOS
//
//  Created by Seonwoo Kim on 12/26/23.
//

import UIKit
import SnapKit

final class UpcomingViewController: UIViewController {
    
    private let values: [String] = ["A","B","C","D","E","F","G","H","I"]
    
    var progressBar: UIProgressView!
    var progress: Float = 0.0
    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("프로그래스바 상승", for: .normal)
        startButton.addTarget(self, action: #selector(startProgress), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "hi"
        
        return textLabel
    }()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
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
    }
    
    func setConstraints() {
        progressBar.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
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
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            values.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return values[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            print("row: \(row)")
            print("value: \(values[row])")
            textLabel.text = values[row]
        }
}
