import Foundation
import UIKit

class ConnectDeviceViewController : BaseViewController, ConnectionDeviceView {
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var devices = [DeviceViewModel]()
    var presenter : ConnectionDevicePresenter!
    var router : Router!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter.viewDidLoad()
    }
    
    @IBAction func scanAction(_ sender: Any) {
        presenter.scan()
    }
    
    func scanHasBeenLaunched(){
        scanButton.isEnabled = false
        progressIndicatorView.isHidden = false
        progressIndicatorView.startAnimating()
    }
    
    func scanHasBeenStopped(){
        scanButton.isEnabled = true
        progressIndicatorView.isHidden = true
    }
    
    func devicesFounded(with device : DeviceViewModel) {
        self.devices.append(device)
        self.tableView.reloadData()
    }
    
    func deviceConnected(named deviceName: String) {
        scanButton.setTitle("Scanner les dispositifs", for: UIControl.State.disabled)
        scanButton.isEnabled = true
        progressIndicatorView.isHidden = true
        router.go(from: self, to: .tracking)
    }
}

extension ConnectDeviceViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath) as! DeviceTableViewCell
        let currentDevice = devices[indexPath.row]
        cell.deviceLogoImageView.image = UIImage(named: currentDevice.deviceLogo)
        cell.typeLogoImageView.image = UIImage(named: currentDevice.deviceTypeLogo)
        cell.deviceNameLabel.text = currentDevice.name
        cell.addressNameLabel.text = currentDevice.address
        return cell
    }
    
}

extension ConnectDeviceViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        progressIndicatorView.isHidden = false
        scanButton.isEnabled = false
        scanButton.setTitle("Connexion en cours", for: UIControl.State.disabled)
        let device = devices[indexPath.row]
        presenter.didSelect(device: device)
    }
}
