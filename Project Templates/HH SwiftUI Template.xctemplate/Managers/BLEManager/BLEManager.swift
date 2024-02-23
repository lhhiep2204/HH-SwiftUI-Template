//___FILEHEADER___

import CoreBluetooth

protocol BLEManagerDelegate: AnyObject {
    func bleManager(didDiscover peripheral: CBPeripheral)
    func bleManager(didConnect peripheral: CBPeripheral)
    func bleManager(didFailToConnect peripheral: CBPeripheral, error: Error?)
    func bleManager(didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)

    func bleManager(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
}

extension BLEManagerDelegate {
    func bleManager(didDiscover peripheral: CBPeripheral) { }
    func bleManager(didConnect peripheral: CBPeripheral) { }
    func bleManager(didFailToConnect peripheral: CBPeripheral, error: Error?) { }
    func bleManager(didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) { }

    func bleManager(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) { }
}

class BLEManager: NSObject {
    // MARK: - Properties
    static let shared: BLEManager = {
        let manager = BLEManager()
        manager.center = CBCentralManager(delegate: manager, queue: DispatchQueue.main)
        return manager
    }()

    private var center: CBCentralManager?

    weak var delegate: BLEManagerDelegate?
}

// MARK: - Methods
extension BLEManager {
    var authorizationStatus: CBManagerAuthorization {
        return CBCentralManager.authorization
    }

    func startScan(withServices serviceUUIDs: [CBUUID]? = nil ) {
        print("BLEManager startScan")
        center?.scanForPeripherals(withServices: serviceUUIDs,
                                   options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
    }

    func stopScan() {
        print("BLEManager stopScan")
        center?.stopScan()
    }

    func connect(peripheral: CBPeripheral) {
        if peripheral.state == .connected || peripheral.state == .connecting {
            disconnect(peripheral: peripheral)
        }

        print("BLEManager connect \(peripheral.identifier.uuidString)")
        center?.connect(peripheral, options: nil)
    }

    func disconnect(peripheral: CBPeripheral) {
        print("BLEManager disconnect \(peripheral.identifier.uuidString)")
        center?.cancelPeripheralConnection(peripheral)
    }
}

// MARK: - CBCentralManagerDelegate
extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("BLEManager state: poweredOn")
        case .poweredOff:
            print("BLEManager state: poweredOff")
        case .unauthorized:
            print("BLEManager state: unauthorized")
        default:
            print("BLEManager state: unknown")
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        print("BLEManager didDiscover: \(peripheral.identifier.uuidString)")
        delegate?.bleManager(didDiscover: peripheral)
    }

    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral) {
        print("BLEManager didConnect: \(peripheral.identifier.uuidString)")

        peripheral.delegate = self
        peripheral.discoverServices(nil)

        delegate?.bleManager(didConnect: peripheral)
    }

    func centralManager(_ central: CBCentralManager,
                        didFailToConnect peripheral: CBPeripheral,
                        error: Error?) {
        print("BLEManager didFailToConnect: \(peripheral.identifier.uuidString)")
        delegate?.bleManager(didFailToConnect: peripheral, error: error)
    }

    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?) {
        print("BLEManager didDisconnectPeripheral: \(peripheral.identifier.uuidString)")
        delegate?.bleManager(didDisconnectPeripheral: peripheral, error: error)
    }
}

// MARK: - CBPeripheralDelegate
extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?) {
        print("BLEManager didDiscoverServices: \(peripheral.identifier.uuidString)")

        guard let services = peripheral.services else { return }

        services.forEach { peripheral.discoverCharacteristics(nil, for: $0) }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        print("BLEManager didDiscoverCharacteristicsFor: \(peripheral.identifier.uuidString)")
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        print("BLEManager didWriteValueFor: \(peripheral.identifier.uuidString)")
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        print("BLEManager didUpdateValueFor: \(peripheral.identifier.uuidString)")
        delegate?.bleManager(peripheral, didUpdateValueFor: characteristic, error: error)
    }
}
