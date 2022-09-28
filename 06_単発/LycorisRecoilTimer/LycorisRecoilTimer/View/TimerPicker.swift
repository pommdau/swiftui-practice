//
//  TimerPicker.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//
//  ref: https://gist.github.com/takoikatakotako/df99952066e24a24173433e84187a86d#file-contentview-swift

import SwiftUI

struct TimePicker: UIViewRepresentable {
    
    var hour: Binding<Int>
    var minute: Binding<Int>
    var second: Binding<Int>
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TimePicker>) -> UIPickerView {
        let picker = UIPickerView()
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TimePicker>) {
        view.selectRow(hour.wrappedValue, inComponent: 0, animated: false)
        view.selectRow(minute.wrappedValue, inComponent: 1, animated: false)
        view.selectRow(second.wrappedValue, inComponent: 2, animated: false)
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: TimePicker
        
        init(_ pickerView: TimePicker) {
            parent = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0:
                return 24
            case 1, 2:
                return 60
            default:
                return 0
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 48
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(format: "%02d", row)
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0:
                return parent.hour.wrappedValue = row
            case 1:
                return parent.minute.wrappedValue = row
            case 2:
                parent.second.wrappedValue = row
            default:
                break
            }
        }
    }
}
