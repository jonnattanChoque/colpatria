//
//  FilterView.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit
import PureLayout

protocol FilterViewDelegate: AnyObject {
    func didUpdateAdultFilter(isAdult: Bool)
    func didUpdateLanguageFilter(selectedLanguage: String)
    func didUpdateVoteAverageFilter(minVoteAverage: Float, maxVoteAverage: Float)
    func didApplyFilter()
    func didCancelFilter()
    func didRemoveFilter()
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?
    private let marginHorizontal: CGFloat = 20
    private let marginButton: CGFloat = 20
    private let marginLeft: CGFloat = 60
    private let size: CGFloat = 150
    private let min: CGFloat = 0
    private let max: CGFloat = 10
    private let step: Float = 1

    let languageOptions = Json.shared.read()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.title
        label.font = UIFont.boldSystemFont(ofSize: FontSize.big.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adultSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    private let languagePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let minVoteAverageSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.isContinuous = true
        slider.value = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let maxVoteAverageSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.isContinuous = true
        slider.value = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let adultLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.Adult
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.Languague
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.Average
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minVoteAverageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.Min
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxVoteAverageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.Filter.Max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var applyFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Home.Filter.Apply, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(applyFilterButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Home.Filter.Cancel, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.medium.rawValue)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cancelFilterButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Home.Filter.Remove, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(removeFilterButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.accessibilityIdentifier = "FilterView"
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(cancelFilterButton)
        addSubview(titleLabel)
        addSubview(adultLabel)
        addSubview(adultSwitch)
        addSubview(languageLabel)
        addSubview(languagePicker)
        addSubview(voteAverageLabel)
        addSubview(minVoteAverageSlider)
        addSubview(maxVoteAverageSlider)
        addSubview(minVoteAverageLabel)
        addSubview(maxVoteAverageLabel)
        addSubview(removeFilterButton)
        addSubview(applyFilterButton)
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        
        adultSwitch.addTarget(self, action: #selector(adultSwitchChanged), for: .valueChanged)
        minVoteAverageSlider.addTarget(self, action: #selector(voteAverageSliderChanged), for: .valueChanged)
        maxVoteAverageSlider.addTarget(self, action: #selector(voteAverageSliderChanged), for: .valueChanged)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cancelFilterButton.autoPinEdge(toSuperviewMargin: .top, withInset: marginButton)
        cancelFilterButton.autoPinEdge(toSuperviewMargin: .trailing, withInset: marginHorizontal)
        
        
        titleLabel.autoPinEdge(toSuperviewMargin: .top, withInset: marginButton)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        
        adultLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: marginButton)
        adultLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        
        adultSwitch.autoAlignAxis(.horizontal, toSameAxisOf: adultLabel)
        adultSwitch.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        
        languageLabel.autoPinEdge(.top, to: .bottom, of: adultLabel, withOffset: marginButton)
        languageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        
        languagePicker.autoPinEdge(.top, to: .bottom, of: languageLabel)
        languagePicker.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        languagePicker.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        languagePicker.autoSetDimension(.height, toSize: size)
        
        voteAverageLabel.autoPinEdge(.top, to: .bottom, of: languagePicker, withOffset: marginButton)
        voteAverageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        
        minVoteAverageLabel.autoPinEdge(.top, to: .bottom, of: voteAverageLabel, withOffset: marginButton)
        minVoteAverageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        
        minVoteAverageSlider.autoAlignAxis(.horizontal, toSameAxisOf: minVoteAverageLabel)
        minVoteAverageSlider.autoPinEdge(toSuperviewEdge: .leading, withInset: marginLeft)
        minVoteAverageSlider.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        
        maxVoteAverageLabel.autoPinEdge(.top, to: .bottom, of: minVoteAverageLabel, withOffset: marginButton)
        maxVoteAverageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        
        maxVoteAverageSlider.autoAlignAxis(.horizontal, toSameAxisOf: maxVoteAverageLabel)
        maxVoteAverageSlider.autoPinEdge(toSuperviewEdge: .leading, withInset: marginLeft)
        maxVoteAverageSlider.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        
        removeFilterButton.autoPinEdge(.top, to: .bottom, of: maxVoteAverageSlider, withOffset: marginButton)
        removeFilterButton.autoPinEdge(toSuperviewEdge: .leading, withInset: marginHorizontal)
        removeFilterButton.autoSetDimension(.width, toSize: size)
        
        applyFilterButton.autoPinEdge(.top, to: .bottom, of: maxVoteAverageSlider, withOffset: marginButton)
        applyFilterButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginHorizontal)
        applyFilterButton.autoSetDimension(.width, toSize: size)
    }
    
    
    @objc private func adultSwitchChanged() {
        delegate?.didUpdateAdultFilter(isAdult: adultSwitch.isOn)
    }
    
    @objc private func voteAverageSliderChanged(_ sender: UISlider) {
        var minVoteAverage = min
        var maxVoteAverage = max
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        if sender == minVoteAverageSlider {
            minVoteAverage = CGFloat(sender.value)
        } else if sender == maxVoteAverageSlider {
            maxVoteAverage = CGFloat(sender.value)
        }
        delegate?.didUpdateVoteAverageFilter(minVoteAverage: Float(minVoteAverage), maxVoteAverage: Float(maxVoteAverage))
    }
    
    @objc func applyFilterButtonTapped(_ sender: UIButton) {
        minVoteAverageSlider.value = Float(min)
        maxVoteAverageSlider.value = Float(max)
        delegate?.didApplyFilter()
    }
    
    @objc func cancelFilterButtonTapped(_ sender: UIButton) {
        delegate?.didCancelFilter()
    }
    
    @objc func removeFilterButtonTapped(_ sender: UIButton) {
        delegate?.didRemoveFilter()
    }
}

extension FilterView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageOptions?.count ?? .zero
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageOptions?[row].englishName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let languageCode = languageOptions?[row].iso6391 ?? ""
        delegate?.didUpdateLanguageFilter(selectedLanguage: languageCode)
    }
}
