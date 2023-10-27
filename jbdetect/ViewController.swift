//  ViewController.swift

//  JB Detect by Kalana (Anon LK)
//  Created by Kalana Sankalpa (Anon LK).

import UIKit
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let isJBDetected = chkJB()
        if isJBDetected {
            //Jailbreak is Detected
            
        } else {
            //Jailbreak is not detected
        }
    }

    func chkJB() -> Bool {

        //Create labels to display detections
        let appName = createLabel(withText: "JB Detect By Kalana (Anon LK)", frame: CGRect(x: 20, y: 50, width: 280, height: 60))
        
        let JBLabel = createLabel(withText: "JailBreak Detection: ", frame: CGRect(x: 20, y: 100, width: 280, height: 60))
        
        let JBDetectMethdLabel = createLabel(withText: "Detection Methods: N/A", frame: CGRect(x: 20, y: 150, width: 280, height: 60))

        //Display messages if the JB is detected with detection methods
        if sim()  == "JBroken" || jbPath() == "JBroken" || slPath() == "JBroken" || dyLibName() == "JBroken" || checkPkgManager() == "JBroken" {
            JBLabel.text = "JailBreak Detection: True"
            JBDetectMethdLabel.text = "Detection Methods: "
            
            if sim() == "JBroken" {
                //Simulator detected
                JBDetectMethdLabel.text! += "\n  Simulator"
            }
            
            if jbPath() == "JBroken" {
                //jailbreak-related files, directories, and binaries are detected 
                JBDetectMethdLabel.text! += "\n  JB Related Paths"
            }
            
            if slPath() == "JBroken" {
                //jailbreak-related symbolic links are detected
                JBDetectMethdLabel.text! += "\n  JB Symbolic Links"
            }
            
            if dyLibName() == "JBroken" {
                //jailbreak-related dynamic links are detected
                JBDetectMethdLabel.text! += "\n  JB Dynamic Libraries"
            }
            
            if checkPkgManager() == "JBroken" {
                //jailbreak-related package managers are detected
                JBDetectMethdLabel.text! += "\n  JB Package Managers"
            }
            appName.sizeToFit()
            JBLabel.sizeToFit()
            JBDetectMethdLabel.sizeToFit()
            
            return true
            
        } else {
            JBLabel.text = "JailBreak Detection: False"
            
            appName.sizeToFit()
            JBLabel.sizeToFit()
            JBDetectMethdLabel.sizeToFit()
            
            return false
        }
    }

    // Create label to display detection
    func createLabel(withText text: String, frame: CGRect) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        return label
    }


    //check for simulator
    func sim() -> String {
        #if targetEnvironment(simulator)
        return "JBroken"
        #else
        return "notJBroken"
        #endif
    }

    // Check for known jailbreak-related files, directories, and binaries
    func jbPath() -> String {
        let fm = FileManager.default
        let jbPaths = [
            "/Applications/Cydia.app",
            "/usr/libexec/cydia",
            "/Applications/Sileo.app",
            "/usr/libexec/sileo",
            "/etc/apt",
            "/private/var/lib/cydia",
            "/../../../../bin/bash",
            "/usr/sbin/sshd",
            "/usr/bin/sshd",
            "/usr/bin/ssh",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/private/var/lib/apt",
            "/private/var/tmp/cydia.log",
            "/Applications/WinterBoard.app",
            "/var/lib/cydia",
            "/private/etc/dpkg/origins/debian",
            "/bin.sh",
            "/private/etc/apt",
            "/etc/ssh/sshd_config",
            "/private/etc/ssh/sshd_config",
            "/Applications/SBSetttings.app",
            "/private/var/mobileLibrary/SBSettingsThemes/",
            "/private/var/stash",
            "/usr/libexec/sftp-server",
            "/usr/sbin/frida-server",
            "/usr/bin/cycript",
            "/usr/local/bin/cycript",
            "/usr/lib/libcycript.dylib",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/Applications/FakeCarrier.app",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/usr/libexec/ssh-keysign",
            "/Applications/blackra1n.app",
            "/Applications/IntelliScreen.app",
            "/Applications/Snoop-itConfig.app",
            "/var/checkra1n.dmg",
            "/var/binpack",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/bin/sh",
            "/bin/su",
            "/pguntether",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/var/cache/apt",
            "/var/log/syslog",
            "/var/mobile/Media/.evasi0n7_installed",
            "/var/tmp/cydia.log"
        ]

        for path in jbPaths {
            if fm.fileExists(atPath: path) {
                return "JBroken"
            }
        }
        return "notJBroken"
    }

    // Check for symbolic links
    func slPath() -> String {
        let fm = FileManager.default
        let slPaths = [
            "/Applications",
            "/var/stash/Library/Ringtones",
            "/var/stash/Library/Wallpaper",
            "/var/stash/usr/include",
            "/var/stash/usr/libexec",
            "/var/stash/usr/share",
            "/var/stash/usr/arm-apple-darwin9",
            "/Library/MobileSubstrate/DynamicLibraries"
        ]

        for linkPath in slPaths {
            if fm.fileExists(atPath: linkPath, isDirectory: nil) {
                let attributes = try? fm.attributesOfItem(atPath: linkPath)
                if attributes?[FileAttributeKey.type] as! String == FileAttributeType.typeSymbolicLink.rawValue {
                    return "JBroken"
                }
            }
        }
        return "notJBroken"
    }

    // Check for Dynamic links
    func dyLibName() -> String {
        let dyLibNames = [
            "cyinject",
            "libcycript",
            "FridaGadget",
            "zzzzLiberty.dylib",
            "SSLCertificatePinningBypass2.dylib",
            "0Shadow.dylib",
            "MobileSubstrate.dylib",
            "libsparkapplist.dylib",
            "SubstrateInserter.dylib",
            "zzzzzzUnSub.dylib",
            "...!@#",
            "/usr/lib/Cephei.framework/Cephei"
        ]

        for dyLibName in dyLibNames {
            if dlopen(dyLibName, RTLD_LAZY) != nil {
                return "JBroken"
            }
        }
        return "notJBroken"
    }

    //check for JB package managers
    func checkPkgManager() -> String {
        let pkgManagerURLs = [
            "cydia://package/com.example.package",
            "sileo://package/com.example.package",
            "zbra://package/com.example.package",
            "installer://package/com.example.package",
            "rockapp://package/com.example.package",
            "icy://package/com.example.package",
            "saily://package/com.example.package",
            "packix://package/com.example.package",
            "undecimus://package/com.example.package",
            "xina://package/com.example.package",
            "filza://package/com.example.package",
            "santander://package/com.example.package",
            "apt-repo://package/com.example.package"
        ]
    
        for url in pkgManagerURLs {
            if let packageURL = URL(string: url), UIApplication.shared.canOpenURL(packageURL) {
                return "JBroken"
            }
        }
        return "notJBroken"
    }

}
