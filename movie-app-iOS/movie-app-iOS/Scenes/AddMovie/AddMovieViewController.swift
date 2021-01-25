//
//  AddMovieViewController.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 07/11/2020.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SimpleCheckbox
import SKCountryPicker

class AddMovieViewController: UIViewController {
    var ref: DatabaseReference?
    let listView = ListMovieViewController()
    var ratings: String?
    var ticketPrice: String?
    var ratingsList = ["", "1.0", "2.0", "3.0", "4.0", "5.0"]
    let ticketPriceList = ["", "1000", "1500", "2000", "2500"]
    var pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    var containerView = UIStackView()
    var actionCheckbox = Checkbox()
    var actionCheckboxLabel = UILabel()
    var adventureCheckbox = Checkbox()
    var adventureCheckboxLabel = UILabel()
    var horrorCheckbox = Checkbox()
    var horrorCheckboxLabel = UILabel()
    var scifiCheckbox = Checkbox()
    var scifiCheckboxLabel = UILabel()
    var dramaCheckbox = Checkbox()
    var dramaCheckboxLabel = UILabel()
    var romanceCheckbox = Checkbox()
    var romanceCheckboxLabel = UILabel()
    var addPhotoButton = UIButton()
    var addMovieButton = UIButton()
    var titleTextField = UITextField()
    var genreTextField = UITextField()
    var ratingTextField = UITextField()
    var countryTextField = UITextField()
    var releaseDateTextField = UITextField()
    var ticketPriceTextField = UITextField()
    var descriptionTextField = UITextField()
    let datePicker = UIDatePicker()
    var imageView = UIImageView()
    var scrollView = UIScrollView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        navigationController?.isNavigationBarHidden = false
        setNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func layoutViews() {
        createPickerView()
        dismissPickerView()
        createPicker()
        setupScrollView()
        setupContainerView()
        setupInputTextField(placeholder: AddMovieConstants.titlePlaceholder, textField: titleTextField)
        setupInputTextField(placeholder: AddMovieConstants.ratingPlaceholder, textField: ratingTextField)
        setupInputTextField(placeholder: AddMovieConstants.countryPlaceholder, textField: countryTextField)
        createCountryPicker()
        setupInputTextField(placeholder: AddMovieConstants.releasePlaceholder, textField: releaseDateTextField)
        setupInputTextField(placeholder: AddMovieConstants.ticketPlaceholder, textField: ticketPriceTextField)
        setupActionCheckbox()
        setupActionCheckboxLabel()
        setupAdventureCheckbox()
        setupAdventureCheckboxLabel()
        setupHorrorCheckbox()
        setupHorrorCheckboxLabel()
        setupScifiCheckbox()
        setupScifiCheckboxLabel()
        setupDramaCheckbox()
        setupDramaCheckboxLabel()
        setupRomanceCheckbox()
        setupRomanceCheckboxLabel()
        setupDescriptionTextField(descriptionTextField)
        setupInputTextField(placeholder: AddMovieConstants.genrePlaceholder, textField: genreTextField)
        setupAddPhoto()
        setupImageView()
        setupAddMovieButton()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.frame = self.view.bounds
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 70)
        scrollView.bounces = true
    }
    
    func setupContainerView() {
        scrollView.addSubview(containerView)
        containerView.axis = .vertical
        containerView.distribution = .equalSpacing
        containerView.snp.makeConstraints { (make) in
            //            make.edges.equalTo(view).inset(UIEdgeInsets(top: 90, left: 20, bottom: 40, right: 20))
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.6)
        }
    }
    
    func setupInputTextField(placeholder: NSAttributedString, textField: UITextField) {
        containerView.addArrangedSubview(textField)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.attributedPlaceholder = placeholder
        textField.snp.makeConstraints { (make) in
            make.height.equalTo(containerView).multipliedBy(0.08)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
    }
    
    func setupActionCheckbox() {
        scrollView.addSubview(actionCheckbox)
        actionCheckbox.backgroundColor = .clear
        actionCheckbox.checkedBorderColor = .blue
        actionCheckbox.borderStyle = .square
        actionCheckbox.layer.borderWidth = 1
        actionCheckbox.checkmarkStyle = .tick
        actionCheckbox.useHapticFeedback = true
        actionCheckbox.addTarget(self, action: #selector(actionCheckboxValueChanged(sender:)), for: .valueChanged)
        actionCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    @objc func actionCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(actionCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = actionCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }
    }
    
    func setupActionCheckboxLabel() {
        scrollView.addSubview(actionCheckboxLabel)
        actionCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        actionCheckboxLabel.textColor = .black
        actionCheckboxLabel.text = "Action"
        actionCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.equalTo(actionCheckbox.snp.left).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
    }
    
    func setupAdventureCheckbox() {
        scrollView.addSubview(adventureCheckbox)
        adventureCheckbox.backgroundColor = .clear
        adventureCheckbox.checkedBorderColor = .blue
        adventureCheckbox.borderStyle = .square
        adventureCheckbox.layer.borderWidth = 1
        adventureCheckbox.checkmarkStyle = .tick
        adventureCheckbox.useHapticFeedback = true
        adventureCheckbox.addTarget(self, action: #selector(adventureCheckboxValueChanged(sender:)), for: .valueChanged)
        adventureCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.equalTo(actionCheckboxLabel.snp.left).offset(80)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    @objc func adventureCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(adventureCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = adventureCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }
    }
    
    func setupAdventureCheckboxLabel() {
        scrollView.addSubview(adventureCheckboxLabel)
        adventureCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        adventureCheckboxLabel.textColor = .black
        adventureCheckboxLabel.numberOfLines = 1
        adventureCheckboxLabel.text = "Adventure"
        adventureCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.equalTo(adventureCheckbox.snp.left).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
    }
    
    func setupHorrorCheckbox() {
        scrollView.addSubview(horrorCheckbox)
        horrorCheckbox.backgroundColor = .clear
        horrorCheckbox.checkedBorderColor = .blue
        horrorCheckbox.borderStyle = .square
        horrorCheckbox.layer.borderWidth = 1
        horrorCheckbox.checkmarkStyle = .tick
        horrorCheckbox.useHapticFeedback = true
        horrorCheckbox.addTarget(self, action: #selector(horrorCheckboxValueChanged(sender:)), for: .valueChanged)
        horrorCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(actionCheckbox.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setupHorrorCheckboxLabel() {
        scrollView.addSubview(horrorCheckboxLabel)
        horrorCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        horrorCheckboxLabel.textColor = .black
        horrorCheckboxLabel.numberOfLines = 1
        horrorCheckboxLabel.text = "Horror"
        horrorCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(actionCheckbox.snp.bottom).offset(20)
            make.left.equalTo(horrorCheckbox.snp.left).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
    }
    
    @objc func horrorCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(horrorCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = horrorCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }
    }
    
    func setupScifiCheckbox() {
        scrollView.addSubview(scifiCheckbox)
        scifiCheckbox.backgroundColor = .clear
        scifiCheckbox.checkedBorderColor = .blue
        scifiCheckbox.borderStyle = .square
        scifiCheckbox.layer.borderWidth = 1
        scifiCheckbox.checkmarkStyle = .tick
        scifiCheckbox.useHapticFeedback = true
        scifiCheckbox.addTarget(self, action: #selector(scifiCheckboxValueChanged(sender:)), for: .valueChanged)
        scifiCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(actionCheckbox.snp.bottom).offset(20)
            make.left.equalTo(horrorCheckboxLabel.snp.left).offset(80)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setupScifiCheckboxLabel() {
        scrollView.addSubview(scifiCheckboxLabel)
        scifiCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        scifiCheckboxLabel.textColor = .black
        scifiCheckboxLabel.numberOfLines = 1
        scifiCheckboxLabel.text = "Sci-fi"
        scifiCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(adventureCheckbox.snp.bottom).offset(20)
            make.left.equalTo(scifiCheckbox.snp.left).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
    }
    
    @objc func scifiCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(scifiCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = scifiCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }
    }
    
    func setupDramaCheckbox() {
        scrollView.addSubview(dramaCheckbox)
        dramaCheckbox.backgroundColor = .clear
        dramaCheckbox.checkedBorderColor = .blue
        dramaCheckbox.borderStyle = .square
        dramaCheckbox.layer.borderWidth = 1
        dramaCheckbox.checkmarkStyle = .tick
        dramaCheckbox.useHapticFeedback = true
        romanceCheckbox.addTarget(self, action: #selector(dramaCheckboxValueChanged(sender:)), for: .valueChanged)
        dramaCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(scifiCheckbox.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setupDramaCheckboxLabel() {
        scrollView.addSubview(dramaCheckboxLabel)
        dramaCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        dramaCheckboxLabel.textColor = .black
        dramaCheckboxLabel.numberOfLines = 1
        dramaCheckboxLabel.text = "Drama"
        dramaCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scifiCheckbox.snp.bottom).offset(20)
            make.left.equalTo(dramaCheckbox.snp.left).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
    }
    
    @objc func dramaCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(dramaCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = dramaCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }
    }
    
    func setupRomanceCheckbox() {
        scrollView.addSubview(romanceCheckbox)
        romanceCheckbox.backgroundColor = .clear
        romanceCheckbox.checkedBorderColor = .blue
        romanceCheckbox.borderStyle = .square
        romanceCheckbox.layer.borderWidth = 1
        romanceCheckbox.checkmarkStyle = .tick
        romanceCheckbox.useHapticFeedback = true
        romanceCheckbox.addTarget(self, action: #selector(romanceCheckboxValueChanged(sender:)), for: .valueChanged)
        romanceCheckbox.snp.makeConstraints { (make) in
            make.top.equalTo(scifiCheckbox.snp.bottom).offset(20)
            make.left.equalTo(dramaCheckboxLabel.snp.left).offset(80)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setupRomanceCheckboxLabel() {
        scrollView.addSubview(romanceCheckboxLabel)
        romanceCheckboxLabel.font = UIFont.systemFont(ofSize: 14)
        romanceCheckboxLabel.textColor = .black
        romanceCheckboxLabel.numberOfLines = 1
        romanceCheckboxLabel.text = "Romance"
        romanceCheckboxLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scifiCheckbox.snp.bottom).offset(20)
            make.left.equalTo(romanceCheckbox.snp.left).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(15)
        }
    }
    
    @objc func romanceCheckboxValueChanged(sender: Checkbox) {
        if (sender.isChecked) {
            if genreTextField.text != "" {
                genreTextField.text = (genreTextField.text ?? "") + " | \(romanceCheckboxLabel.text ?? String()) "
            }
            else {
                genreTextField.text = romanceCheckboxLabel.text
            }
        }
        else {
            genreTextField.text = ""
        }

    }
    
    func setupDescriptionTextField(_ descriptionTextField: UITextField ) {
        containerView.addArrangedSubview(descriptionTextField)
        descriptionTextField.backgroundColor = .white
        descriptionTextField.layer.cornerRadius = 10
        descriptionTextField.setLeftPaddingPoints(20)
        descriptionTextField.setRightPaddingPoints(20)
        descriptionTextField.attributedPlaceholder = AddMovieConstants.descriptionPlaceholder
        descriptionTextField.snp.makeConstraints { (make) in
            make.height.equalTo(containerView).multipliedBy(0.12)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
    }
    
    func setupAddPhoto() {
        scrollView.addSubview(addPhotoButton)
        addPhotoButton.setTitle(AddMovieConstants.addPhotoTitle, for: .normal)
        addPhotoButton.contentHorizontalAlignment = .center
        addPhotoButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 16)
        addPhotoButton.setTitleColor(.black, for: .normal)
        addPhotoButton.layer.cornerRadius = 5
        addPhotoButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addPhotoButton.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        addPhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(dramaCheckbox.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
    }
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(addPhotoButton.snp.top)
            make.left.equalTo(addPhotoButton.snp.right).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    func setupAddMovieButton() {
        scrollView.addSubview(addMovieButton)
        addMovieButton.setTitle(AddMovieConstants.addMovieTitle, for: .normal)
        addMovieButton.contentHorizontalAlignment = .center
        addMovieButton.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1098039216, blue: 0.2980392157, alpha: 1)
        addMovieButton.titleLabel?.font = addMovieButton.titleLabel?.font.withSize(20)
        addMovieButton.setTitleColor(.white, for: .normal)
        addMovieButton.layer.cornerRadius = 20
        addMovieButton.addTarget(self, action: #selector(handleAddMovie), for: .touchUpInside)
        addMovieButton.snp.makeConstraints { (make) in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(view.snp.height).multipliedBy(0.09)
        }
    }
    
    func createCountryPicker() {
        guard let country = CountryManager.shared.currentCountry else {
            self.countryTextField.text = "Country"
            return
        }
        countryTextField.text = country.countryName
        countryTextField.clipsToBounds = true
        countryTextField.backgroundColor = .white
        countryTextField.addTarget(nil, action: #selector(countryCodeButtonClicked), for: .touchDown)
    }
    
    @objc func countryCodeButtonClicked(_ sender: UITextField) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) {
            [weak self] (country: Country) in
            guard let self = self else { return }
            self.countryTextField.text = country.countryName
    
        }
        countryController.detailColor = UIColor.red
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        print(romanceCheckboxLabel.text ?? "")
        genreTextField.text = romanceCheckboxLabel.text
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        let addButton = UIButton(type: .custom)
        addButton.setTitle(AddMovieConstants.addMovieTitle, for: .normal)
        addButton.setTitleColor(.black, for: .normal)
    }
    
    func getCheckboxValues() {
        if actionCheckbox.isChecked {
            genreTextField.text = actionCheckboxLabel.text
        }
    }
    
    @objc func handleAddMovie() {
        ref = Database.database().reference()
        ref?.child("Movies")
        navigationController?.popViewController(animated: true)
    }
    
    func createPicker() {
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.minuteInterval = 5
        releaseDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    @objc func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        releaseDateTextField.text = strDate
    }
    
    func saveImageToDatabase() {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).jpg")
        if let uploadData = imageView.image?.jpegData(compressionQuality: 0.1){
            storageRef.putData(uploadData, metadata: nil, completion: { (_ , error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                storageRef.downloadURL { url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    let urlString = url.absoluteURL.absoluteString
                    
                    let key = self.ref?.child("Movies").childByAutoId().key
                    var movie = [String: Any]()
                    movie = [
                        "id": key ?? "",
                        "title": self.titleTextField.text ?? "",
                        "genre": self.genreTextField.text ?? "",
                        "rating": self.ratingTextField.text ?? "",
                        "country": self.countryTextField.text ?? "",
                        "releaseDate": self.releaseDateTextField.text ?? "",
                        "ticketPrice": self.ticketPriceTextField.text ?? "",
                        "movieDescription": self.descriptionTextField.text ?? "",
                        "image": urlString
                    ]
                    self.ref?.child("Movies").child(key ?? "").setValue(movie)
                    
                    print("<<<<<<<<>>>>>>>>>>", urlString)
                    
                }
            })
        }
    }
}


extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @objc func handleAddPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImageFromPicker = originalImage
            imageView.image = selectedImageFromPicker
            print(originalImage)
        }
        saveImageToDatabase()
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func createPickerView() {
        pickerView1.delegate = self
        pickerView2.delegate = self
        ratingTextField.inputView = pickerView1
        ticketPriceTextField.inputView = pickerView2
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        ratingTextField.inputAccessoryView = toolBar
        ticketPriceTextField.inputAccessoryView = toolBar
        releaseDateTextField.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(ratingsList.count)
        var countRows: Int = ratingsList.count
        if pickerView == pickerView2 {
            countRows = ticketPriceList.count
        }
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return ratingsList[row]
        }
        else if pickerView == pickerView2 {
            return ticketPriceList[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            ratings = ratingsList[row]
            ratingTextField.text = ratings
            self.pickerView1.isHidden = true
        }
        else if pickerView == pickerView2 {
            ticketPrice = ticketPriceList[row]
            ticketPriceTextField.text = ticketPrice
            self.pickerView2.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.ratingTextField){
            self.pickerView1.isHidden = false
        }
        else if(textField == self.ticketPriceTextField){
            self.pickerView2.isHidden = false
        }
    }
}
