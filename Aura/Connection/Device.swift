struct Device : Equatable {
    let name : String
    let type : DeviceType
    
    func typeToDeviceTypeLogo() -> String {
        switch type {
        case .HEART:
            return "hrv_connected"
        case .SKIN:
            return "electro_dermal_activity_picture_disable"
        case .GYRO:
            return "accelerometer_picture_disable"
        }
    }
    
    enum DeviceType {
        case HEART
        case SKIN
        case GYRO
    }
}



