//
//  ViewController.swift
//  EnergyDemand
//
//  Created by Matthias Cwik on 10.06.20.
//  Copyright © 2020 Matthias Cwik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var weight_TextField: UITextField!
    
    @IBOutlet weak var weight_Slider: UISlider!
    
    @IBOutlet weak var cW_TextField: UITextField!
    
    @IBOutlet weak var cW_Slider: UISlider!
    
    @IBOutlet weak var crosssection_TextField: UITextField!
    
    @IBOutlet weak var crosssection_Slider: UISlider!
    
    @IBOutlet weak var speed_TextField: UITextField!
    
    @IBOutlet weak var speed_Slider: UISlider!
    
    @IBOutlet weak var power_Label: UILabel!
    
    @IBOutlet weak var vehicleClass_SegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        speed_Slider.value = 100
        
        speed_TextField.text = String(round(speed_Slider.value))

        vehicleClass_SegmentControl.selectedSegmentIndex = 2
        
        setVehicleParameters()
        
        // calculate the total vehicle power in kW
        let power_kW_rounded = calc_rounded_power()
        
        power_Label.text = String(power_kW_rounded) + " kW"
        
        
        
    }
    
    
    // calculate the drag force of the vehicle
    func calc_drag_force(speed: Double, cW: Double, cross_section: Double) -> Double {
        
        // convert speed from km/h to m/s
        let speed_SI = speed*1000/3600
        
        // define air density at 20°C
        let air_density = 1.202 // kg/m^3
        
        // calculate the aerodynamic drag force
        let drag_force = 0.5 * air_density * cW * cross_section * speed_SI * speed_SI
        
        return drag_force
        
    }
    
    // calculate the road friction force
    func calc_road_friction_force(weight:Float) -> Double {
        
        // gravitational constant
        let g = 9.81 // m/s^2
        
        // road rolling resistance coefficient
        let c_rr = 0.11 // [-]
        
        let road_friction_force = Double(weight) * g * c_rr
        
        return road_friction_force
        
    }
    
    func calc_total_force(drag_force:Double, road_friction_force:Double) -> Double {
        
        
        // calculate the total force by summing up all forces
        let total_force = drag_force + road_friction_force
        
        return total_force
    }
    
    
    

    
    // calculate the power demand of the vehicle
    func calcPower(total_force: Double,speed:Double) -> Double {
        
        // convert speed from km/h to m/s
        let speed_SI = speed*1000/3600
        
        let power = total_force * speed_SI
        
        return power
    }
    
    
    func calc_rounded_power() -> Double {
        
        // define variables from Slider values
        let speed = speed_Slider.value
        let cW = cW_Slider.value
        let cross_section = crosssection_Slider.value
        let weight = weight_Slider.value
        
        // calculate the aerodynamic drag force
        let drag_force = calc_drag_force(speed: Double(speed), cW: Double(cW), cross_section: Double(cross_section))
        
        // calculate the road friction force
        let road_friction_force = calc_road_friction_force(weight: weight)
        
        let total_force = calc_total_force(drag_force: drag_force, road_friction_force: road_friction_force)
        
        let power = calcPower(total_force: total_force, speed: Double(speed))
        
        // calculate the power in kW
        let power_kW = power/1000
        
        // calculate rounded power
        let power_kW_rounded = round(power_kW*10)/10
        
        return power_kW_rounded
    }
    
    // set the Slider and Text field values
    func setVehicleParameters(){
        if vehicleClass_SegmentControl.selectedSegmentIndex == 0{
            weight_Slider.value = 1000
            weight_TextField.text = String(round(weight_Slider.value))
            cW_Slider.value = 0.31
            cW_TextField.text = String(cW_Slider.value)
            crosssection_Slider.value = 1.8
            crosssection_TextField.text = String(crosssection_Slider.value)
            
            // update the total power
            let power_kW_rounded = calc_rounded_power()
            power_Label.text = String(power_kW_rounded) + " kW"
        }
        else if vehicleClass_SegmentControl.selectedSegmentIndex == 1{
            weight_Slider.value = 1500
            weight_TextField.text = String(round(weight_Slider.value))
            cW_Slider.value = 0.25
            cW_TextField.text = String(cW_Slider.value)
            crosssection_Slider.value = 2
            crosssection_TextField.text = String(crosssection_Slider.value)
            
            // update the total power
            let power_kW_rounded = calc_rounded_power()
            power_Label.text = String(power_kW_rounded) + " kW"
            
        }
        else if vehicleClass_SegmentControl.selectedSegmentIndex == 2{
            weight_Slider.value = 2000
            weight_TextField.text = String(round(weight_Slider.value))
            cW_Slider.value = 0.23
            cW_TextField.text = String(cW_Slider.value)
            crosssection_Slider.value = 2
            crosssection_TextField.text = String(crosssection_Slider.value)
            // update the total power
            let power_kW_rounded = calc_rounded_power()
            power_Label.text = String(power_kW_rounded) + " kW"
            }
        else if vehicleClass_SegmentControl.selectedSegmentIndex == 3{
            weight_Slider.value = 2200
            weight_TextField.text = String(round(weight_Slider.value))
            cW_Slider.value = 0.23
            cW_TextField.text = String(cW_Slider.value)
            crosssection_Slider.value = 2
            crosssection_TextField.text = String(crosssection_Slider.value)
            
            // update the total power
            let power_kW_rounded = calc_rounded_power()
            power_Label.text = String(power_kW_rounded) + " kW"
            }
        else if vehicleClass_SegmentControl.selectedSegmentIndex == 4{
            weight_Slider.value = 2500
            weight_TextField.text = String(round(weight_Slider.value))
            cW_Slider.value = 0.2
            cW_TextField.text = String(cW_Slider.value)
            crosssection_Slider.value = 1.8
            crosssection_TextField.text = String(crosssection_Slider.value)
            
            // update the total power
            let power_kW_rounded = calc_rounded_power()
            power_Label.text = String(power_kW_rounded) + " kW"
            }
    }
    
    
    // change the TextField value on Slider change
    @IBAction func weight_change_Slider(_ sender: Any) {
        
        weight_TextField.text = String(round(weight_Slider.value))
        
        let power_kW_rounded = calc_rounded_power()
        
        power_Label.text = String(power_kW_rounded) + " kW"
    }
    
    // change the TextField value on Slider change
    @IBAction func cW_change_Slider(_ sender: Any) {
    
        cW_TextField.text = String(round(cW_Slider.value*100)/100)
        
        let power_kW_rounded = calc_rounded_power()
    
        power_Label.text = String(power_kW_rounded) + " kW"
    
    }
    
    // change the TextField value on Slider change
    
    @IBAction func crosssection_change_Slider(_ sender: Any) {
        
        crosssection_TextField.text = String(round(crosssection_Slider.value*10)/10)
        
        let power_kW_rounded = calc_rounded_power()
        
        power_Label.text = String(power_kW_rounded) + " kW"
        
        
    }
    
    // change the TextField value on Slider change
    @IBAction func speed_change_Slider(_ sender: Any) {
        
        speed_TextField.text = String(round(speed_Slider.value))
        
        let power_kW_rounded = calc_rounded_power()
        
        power_Label.text = String(power_kW_rounded) + " kW"
    }
            
    @IBAction func VehicleClass_value_changed(_ sender: Any) {
        
         setVehicleParameters()
    
    }
    
    
}

