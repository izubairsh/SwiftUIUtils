//
//  CustomTextField.swift
//  osbc
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation
import SwiftUI

public struct CustomTextField: View {
    var placeholder: String = ""
    var height: CGFloat = 60
    @Binding var text: String
    
    public init(placeholder: String = "", height: CGFloat = 60, text: Binding<String>){
        self.placeholder = placeholder
        self.height = height
        self._text = text
    }
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .textContentType(.oneTimeCode)
            .autocapitalization(.none)
            .frame(height: height)
            .padding(.horizontal, 10)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
            
    }
}

public struct CustomTextField1: View {
    var placeholder: String = ""
    var height: CGFloat = 60
    @Binding var text: String
    @Binding var error: String
    
    public init(placeholder: String = "", height: CGFloat = 60, text: Binding<String>, error: Binding<String>){
        self.placeholder = placeholder
        self.height = height
        self._text = text
        self._error = error
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2){
        TextField(placeholder, text: $text)
            .textContentType(.oneTimeCode)
            .autocapitalization(.none)
            .frame(height: height)
            .padding(.horizontal, 10)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
            Text(error)
                .foregroundColor(.red)
        }
    }
}

public struct SecureTextField: View {
    var placeholder: String
    var height: CGFloat = 60
    @Binding var text: String
    @Binding var error: String
    @State private var isSecured: Bool = true
    
    public init(placeholder: String = "", height: CGFloat = 60, text: Binding<String>, error: Binding<String>){
        self.placeholder = placeholder
        self.height = height
        self._text = text
        self._error = error
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2){
            ZStack(alignment: .trailing){
                VStack{
                    if isSecured {
                        SecureField(placeholder, text: $text)
                            .textContentType(.oneTimeCode)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .textContentType(.oneTimeCode)
                .autocapitalization(.none)
                .frame(height: height)
                .padding(.horizontal, 10)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1))
                Image(systemName: isSecured ? "eye" : "eye.slash")
                    .padding(.trailing)
                    .onTapGesture {
                        isSecured.toggle()
                    }
            }
            Text(error)
                .foregroundColor(.red)
        }
    }
}

public struct DatePickerTextField: UIViewRepresentable {
    
    private let textfield = UITextField()
    private let datepicker = UIDatePicker()
    
    public var placeholder: String
    private let helper = Helper()
    private let dateformater: DateFormatter = {
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd"
        return dateformater
    }()
    
    @Binding public var date: Date?
    var temp = ""
    
    public init(placeholder: String, date: Binding<Date?>){
        self._date = date
        self.placeholder = placeholder
    }
    
    public func makeUIView(context: Context) -> UITextField {
        
        self.datepicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            self.datepicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.datepicker.addTarget(self.helper, action: #selector(self.helper.DateValueChanged), for: .valueChanged)
        self.textfield.placeholder = self.placeholder
        self.textfield.inputView = self.datepicker
        
        //accessory view
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexiblespace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.DoneButtonAction))
        
        toolbar.setItems([flexiblespace,doneButton], animated: true)
        self.textfield.inputAccessoryView = toolbar
        
        self.helper.DateChanged = {
            
            self.date = self.datepicker.date
        }
        
        self.helper.doneButtonTapped = {
            
            if self.date == nil {
                
                self.date = self.datepicker.date
            }
            self.textfield.resignFirstResponder()
            
        }
        return self.textfield
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        
        if let selectedDate = self.date {
            uiView.text = self.dateformater.string(from: selectedDate)
        }else{
            uiView.text = temp
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        
        Coordinator()
    }
    
    public class Helper{
        public var DateChanged: (()-> Void)?
        public var doneButtonTapped:(()-> Void)?
        @objc func DateValueChanged(){
            self.DateChanged?()
        }
        @objc func DoneButtonAction(){
            self.doneButtonTapped?()
        }
        
    }
    public class Coordinator{
        
    }
    
}


public struct CustomPickerTextField : UIViewRepresentable {
    
    var data : [String]
    var placeholder : String
    
    @Binding var selectionIndex : Int?
    @Binding var text : String?
    var temp = ""
    
    private let textField = UITextField()
    private let picker = UIPickerView()
    
    public init(data: [String], placeholder: String, selectionIndex: Binding<Int?>, text: Binding<String?>){
        self.data = data
        self.placeholder = placeholder
        self._selectionIndex = selectionIndex
        self._text = text
    }
    
    public func makeCoordinator() -> CustomPickerTextField.Coordinator {
        Coordinator(textfield: self)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CustomPickerTextField>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.backgroundColor = .white
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.inputView = picker
        textField.delegate = context.coordinator
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomPickerTextField>) {
        if let s = text {
            uiView.text = s
        }else{
            uiView.text = temp
        }
        
    }
    
    public class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {
        
        private let parent : CustomPickerTextField
        
        public init(textfield : CustomPickerTextField) {
            self.parent = textfield
        }
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data.count
        }
        public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[row]
        }
        public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.$selectionIndex.wrappedValue = row+1
            
            self.parent.text = self.parent.data[row]
            self.parent.textField.endEditing(true)
            
        }
        public func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
    }
}
