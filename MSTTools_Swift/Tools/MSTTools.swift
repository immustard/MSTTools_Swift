//
//  MSTTools.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/12.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import Photos

// MARK: - Macros
public var kScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

public var kScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

public var kScreenSize: CGSize {
    return UIScreen.main.bounds.size
}

public var kScreenScale: CGFloat {
    return UIScreen.main.scale
}

public let kNavHeight = 64

public let kTabarHeight = 49

public let kSearchBarHeight = 44



// MARK: - 访问权限
open class MSTTools {
    public enum AuthorType {
        case album
        case capture
        case microphone
        case location
    }
    
    public enum AuthorResult {
        case authorized
        case denied
        case notDetermined
    }
    
    /// 根据类型获取是否有访问权限
    ///
    /// - Parameter type: 类型(相册、相机、定位等)
    /// - Returns: 是否可以访问
    public class func authorization(authorType type: AuthorType) -> AuthorResult {
        switch type {
        case .album:
            let author: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()

            switch author {
            case .denied, .restricted:
                return .denied
            case .authorized:
                return .authorized
            case .notDetermined:
                return .notDetermined
            }
        case .capture, .microphone:
            let author: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: type == .capture ? AVMediaTypeVideo : AVMediaTypeAudio)
            switch author {
            case .denied, .restricted:
                return .denied
            case .authorized:
                return .authorized
            case .notDetermined:
                return .notDetermined
            }
        case .location:
            let author: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            switch author {
            case .denied, .restricted:
                return .denied
            case .authorizedWhenInUse, .authorizedAlways:
                return .authorized
            case .notDetermined:
                return .notDetermined
            }
        }
    }
}

// MARK:- 系统
extension MSTTools {
    /// 获取 App 版本号 (浮点型)
    public class func appVersion() -> Double {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! Double
    }
    
    /// 获取 App 版本号 (字符串)
    public class func appStringVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// 获取 App 名称
    public class func appDisplayName() -> String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /// BundleID
    public class func appBundleIdentifier() -> String {
        return Bundle.main.bundleIdentifier!
    }
    
    // 内部版本号 (浮点型)
    public class func bundleVersion() -> Double {
        return Bundle.main.infoDictionary![String(kCFBundleVersionKey)] as! Double
    }
    
    // 内部版本号 (字符串)
    public class func bundleStringVersion() -> String {
        return Bundle.main.infoDictionary![String(kCFBundleVersionKey)] as! String
    }
    
    /// 系统版本号
    public class func systemVersion() -> Double {
        return Double(UIDevice.current.systemVersion)!
    }
    
    /// 手机ID (UUID)
    public class func deviceID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /// 是否是 iPad
    public class func isiPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
}

// MARK: - 状态栏
extension MSTTools {
    /// 设置状态栏颜色
    ///
    /// - Parameter color: 颜色
    public class func setStatusBarBackgroundColor(_ color: UIColor) {
        let statusBarWindow: UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar: UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        
        if statusBarWindow.responds(to: #selector(setter: AVMutableVideoCompositionInstruction.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
}

// MARK: - 文件操作
extension MSTTools {
    /// 获取 Documents 路径
    public class func documentsPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
    /// 获取 Library 路径
    public class func libraryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    }
    
    /// 获取 Cache 路径
    public class func cachePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    
    /// 获取 Home 路径
    public class func homePath() -> String {
        return NSHomeDirectory()
    }
    
    /// 获取 tmp 路径
    public class func tmpPath() -> String {
        return NSTemporaryDirectory()
    }
    
    /// 根据文件名获取文件路径
    ///
    /// - Parameter fileName: 文件名
    /// - Returns: 文件路径 (Documents目录)
    public class func filePath(name fileName: String) -> String {
        return documentsPath().appending("/\(fileName)")
    }
    
    /// 根据文件路径获取文件名
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 文件名
    public class func fileName(path: String) -> String {
        let arr: Array<String> = path.components(separatedBy: "/")
        
        return arr.last!
    }
    
    /// 根据文件路径获取文件名(不含后缀)
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 文件名(不含后缀)
    public class func fileNameWithoutSuffix(path: String) -> String? {
        let arr: Array<String> = path.components(separatedBy: "/")
        
        if arr.count > 0 {
            let name: String = arr.last!
            
            if let _ = name.range(of: ".", options: .backwards, range: nil, locale: nil) {
                return name.components(separatedBy: ".").first
            } else {
                return name
            }
        }
        return nil
    }
    
    /// 根据文件路径判断文件是否存在
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 是否存在
    public class func fileExist(atPath path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// 根据文件名判断文件是否存在(Documents目录)
    ///
    /// - Parameter fileName: 文件名(Documents目录)
    /// - Returns: 是否存在
    public class func fileExist(withName fileName: String) -> Bool {
        return fileExist(atPath: filePath(name: fileName))
    }
    
    /// 根据文件路径判断是否为文件夹
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 是否为文件夹
    public class func filePathIsDirectory(atPath path: String) -> Bool {
        guard fileExist(atPath: path) else { return false }
        
        var isDir: ObjCBool = false
        _ = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        
        return isDir.boolValue
    }
    
    /// 根据文件路径获取文件大小，若文件路径为文件夹，则返回文件夹内文件大小
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 文件大小，返回 -1 则获取失败
    public class func fileLength(atPath path: String) -> Int64 {
        // 判断是否为文件夹, 以及文件是否存在
        var isDir: ObjCBool = false
        let isExists: Bool = FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        
        guard isExists else { return -1 }
        
        var size: Int64 = -1
        // 开始计算
        if isDir.boolValue {
            // 为文件夹
            let enumerator: FileManager.DirectoryEnumerator = FileManager.default.enumerator(atPath: path)!
            
            for subPath in enumerator {
                let fullPath: String = path.appending("/\(subPath)")
                do {
                    let attr = try FileManager.default.attributesOfItem(atPath: fullPath)
                    (size == -1) ? (size = 0) : (size = -1)
                    size += attr[FileAttributeKey.size] as! Int64
                } catch  {
                    print("File length at path Error: \(error)")
                }
            }
        } else {
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: path)
                size += attr[FileAttributeKey.size] as! Int64
            } catch  {
                print("File length at path Error: \(error)")
                size = -1
            }
        }
        
        return size
    }

    /// 根据文件名(Documents目录)获取文件大小，若文件路径为文件夹，则返回文件夹内文件大小
    ///
    /// - Parameter fileName: 文件名(Documents目录)
    /// - Returns: 文件大小，返回 -1 则获取失败
    public class func fileLength(withName fileName: String) -> Int64 {
        return fileLength(atPath: filePath(name: fileName))
    }
    
    /// 根据文件路径获取文件大小
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 文件大小，返回 nil 则获取失败
    public class func fileSize(atPath path: String) -> String? {
        guard fileExist(atPath: path) else { return nil }
        
        do {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            
            return ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file)
        } catch {
            return nil
        }
    }
    
    /// 根据文件名(Documents目录)获取文件大小
    ///
    /// - Parameter fileName: 文件名(Documents目录)
    /// - Returns: 文件大小，返回 nil 则获取失败
    public class func fileSize(withName fileName: String) -> String? {
        return fileSize(atPath: filePath(name: fileName))
    }
    
    /// 根据文件路径创建文件，若已经存在则不创建
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 是否创建成功
    public class func createFile(atPath path: String) -> Bool {
        guard !fileExist(atPath: path) else { return true }
        
        return FileManager.default.createFile(atPath: path, contents: nil, attributes: nil);
    }
    
    /// 根据文件名(Documents目录)创建文件，若存在则不创建
    ///
    /// - Parameter fileName: 文件名(Documents目录)
    /// - Returns: 是否创建成功
    public class func createFile(withName fileName: String) -> String? {
        let path: String = filePath(name: fileName)
        
        guard !fileExist(atPath: path) else { return path }
        
        if FileManager.default.createFile(atPath: path, contents: nil, attributes: nil) {
            return path
        } else {
            return nil
        }
    }
    
    /// 根据文件路径创建文件夹，若存在则不创建
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 是否创建成功
    public class func createDirectory(atPath path: String) -> String? {
        guard !fileExist(atPath: path) || (fileExist(atPath: path) && !filePathIsDirectory(atPath: path)) else { return path }
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            
            return path
        } catch {
            return nil
        }
    }
    
    /// 根据文件夹名(Documents目录)创建文件夹，若存在则不创建
    ///
    /// - Parameter dirName: 文件夹名(Documents目录)
    /// - Returns: 是否创建成功
    public class func createDirectory(withName dirName: String) -> String? {
        return createDirectory(atPath: filePath(name: dirName))
    }
    
    /// 根据文件路径删除文件
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 是否删除成功
    public class func deleteFile(atPath path: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path)
            
            return true
        } catch {
            return false
        }
    }
    
    /// 根据文件名(Documents目录)删除文件
    ///
    /// - Parameter fileName: 文件名(Documents目录)
    /// - Returns: 是否删除成功
    public class func deleteFile(withName fileName: String) -> Bool {
        return deleteFile(atPath: filePath(name: fileName))
    }
    
    /// 根据文件夹路径，删除文件夹内文件。若路径不为文件夹，则返回 false
    ///
    /// - Parameter path: 文件夹路径
    /// - Returns: 是否删除成功
    public class func deleteDirectoryContent(atPath path: String) -> Bool {
        guard filePathIsDirectory(atPath: path) else { return false }
        
        var result: Bool = true
        
        do {
            let array: [String] = try FileManager.default.contentsOfDirectory(atPath: path)
            
            for subPath in array {
                let fullPath: String = path.appending("/\(subPath)")
                _ = deleteFile(atPath: fullPath)
            }
        } catch {
            result = false
        }
        
        return result
    }
    
    /// 根据文件夹名(Documents目录)删除文件夹内文件。若路径不为文件夹，则返回 false
    ///
    /// - Parameter dirName: 文件夹名(Documents目录)
    /// - Returns: 是否删除成功
    public class func deleteDirectoryContent(withName dirName: String) -> Bool {
        return deleteDirectoryContent(atPath: filePath(name: dirName))
    }
    
    /// 根据文件路径重命名文件，如果新文件路径已存在，则删除新文件
    ///
    /// - Parameters:
    ///   - oldPath: 原文件路径
    ///   - newPath: 新文件路径
    /// - Returns: 是否重命名成功
    public class func renameFile(oldPath: String, newPath: String) -> Bool {
        guard fileExist(atPath: oldPath) else { return false }
        
        if fileExist(atPath: newPath) {
            _ = deleteFile(atPath: newPath)
        }
        
        do {
            try FileManager.default.moveItem(atPath: oldPath, toPath: newPath)
            
            return true
        } catch {
            return false
        }
    }
    
    /// 根据文件名(Documents目录)重命名文件，如果新文件已存在，则删除新文件
    ///
    /// - Parameters:
    ///   - oldName: 原文件名(Documents目录)
    ///   - newName: 新文件名(Documents目录)
    /// - Returns: 是否重命名成功
    public class func renameFile(oldName: String, newName: String) -> Bool {
        return renameFile(oldPath: filePath(name: oldName), newPath: filePath(name: newName))
    }
    
    /// 将字符串写到文件中
    ///
    /// - Parameters:
    ///   - path: 文件路径
    ///   - content: 字符串内容
    /// - Returns: 是否成功
    public class func writeContentToFile(atPath path: String, content: String) -> Bool {
        guard !content.isEmpty else { return false }
        let fos: OutputStream = OutputStream(toFileAtPath: path, append: true)!
        
        fos.open()

        let data: Data! = content.data(using: String.Encoding.utf8)!
        
        _ = data.withUnsafeBytes { fos.write($0, maxLength: data.count) }
        
        fos.close()
        
        return fileExist(atPath: path)
    }
    
    /// 将字符串写到文件中
    ///
    /// - Parameters:
    ///   - fileName: 文件名(Documents目录)
    ///   - content: 字符串内容
    /// - Returns: 是否成功
    public class func writeContentToFile(withName fileName: String, content: String) -> Bool {
        return writeContentToFile(atPath: filePath(name: fileName), content: content)
    }
    
    /// 输出日志
    ///
    /// - Parameter content: 日志内容
    public class func writeLog(content: String) {
        guard !content.mst_isEmptyWithoutWhiteSpace else { return }
        
        let dirName: String = "MSTLogs"
        _ = createDirectory(withName: dirName)
        
        let date: Date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let fileName: String = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS Z"
        
        let str: String = dateFormatter.string(from: date)
        _ = writeContentToFile(atPath: documentsPath().appending("/\(dirName)/\(fileName)"), content: str.appending(": \(content)\n"))
        
        print(content)
    }
}

// MARK: - Json
extension MSTTools {
    /// 将字符串转为 Json
    ///
    /// - Parameter string: 字符串
    /// - Returns: Json
    public class func convertStringToJsonString(string: String) -> String {
        return "\"\(string.replacingOccurrences(of: "\n", with: "\\n").replacingOccurrences(of: "\"", with: "\\\""))\""
    }
    
    /// 将字典转为 Json
    ///
    /// - Parameter dictionary: 字典
    /// - Returns: Json
    public class func convertDictionaryToJsonString(dictionary: Dictionary<String, Any>) -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    /// 将数组转为 Json
    ///
    /// - Parameter array: 数组
    /// - Returns: Json
    public class func convertArrayToJsonString(array: Array<Any>) -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    /// 将 Json 转为字典
    ///
    /// - Parameter string: Json
    /// - Returns: 字典
    public class func convertJsonStringToDic(string: String) -> Dictionary<String, Any>? {
        let data: Data? = string.data(using: .utf8)
        
        guard data != nil else { return nil }
        
        do {
            let dic: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
            
            return dic
        } catch {
            return nil
        }
    }
    
    /// 将 Json 转为数组
    ///
    /// - Parameter string: Json
    /// - Returns: 数组
    public class func convertJsonStringToArray(string: String) -> Array<Any>? {
        let data: Data? = string.data(using: .utf8)
        
        guard data != nil else { return nil }
        
        do {
            let arr: [Any] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<Any>
            
            return arr
        } catch {
            return nil
        }
    }
}

// MARK: - 时间
public enum MSTDateFormat: String {
    // 日期格式
    case yyyy = "yyyy"
    case yyyy_MM = "yyyy-MM"
    case yyyy_MM_dd = "yyyy-MM-dd"
    case MM_dd = "MM-dd"
    
    // 时间格式
    case HH_mm = "HH:mm"
    case HH_mm_ss = "HH:mm:ss"
    
    // 综合格式
    case MM_dd_HH_mm = "MM-dd HH:mm"
    case MM_dd_HH_mm_ss = "MM-dd HH:mm:ss"
    case yyyy_MM_dd_HH_mm = "yyyy-MM-dd HH:mm"
    case yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    case yyyy_MM_dd_HH_mm_ss_SSS = "yyyy-MM-dd HH:mm:ss.SSS"
}

extension MSTTools {
    /// 将时间戳转为 Date
    ///
    /// - Parameter timestamp: 时间戳(1970，毫秒级)
    /// - Returns: Date
    public class func date(fromTimestamp timestamp: String) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp)!/1000)
    }
    
    /// 将 Date 转为时间戳(1970，毫秒级)
    ///
    /// - Parameter date: Date
    /// - Returns: 时间戳(1970，毫秒级)
    public class func timestamp(byDate date: Date) -> String {
        return "\(Int64(date.timeIntervalSince1970 * 1000))"
    }
    
    /// 格式化时间转换为时间戳
    ///
    /// - Parameters:
    ///   - time: 格式化时间
    ///   - format: 时间格式
    /// - Returns: 时间戳(1970，毫秒级)
    public class func timestamp(byFormatTime time: String, format: String) -> String {
        let date: Date? = mp_dateFormat(format: format).date(from: time)
        
        guard date != nil else { return "0" }
        
        return timestamp(byDate: date!)
    }
    
    /// 获取当前时间戳
    ///
    /// - Returns: 时间戳(1970，毫秒级)
    public class func timestamp() -> String {
        return timestamp(byDate: Date())
    }
    
    /// 根据时间戳格式化时间
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳(1970，毫秒级)
    ///   - format: 时间格式
    /// - Returns: 格式化后时间
    public class func formatTime(byTimestamp timestamp: String, format: String) -> String {
        return mp_dateFormat(format: format).string(from: date(fromTimestamp: timestamp))
    }
    
    /// 格式化当前时间
    ///
    /// - Parameter format: 时间格式
    /// - Returns: 格式化后时间
    public class func formatTime(withFormat format: String) -> String {
        return formatTime(byTimestamp: timestamp(), format: format)
    }
    
    /// 系统启动时间
    public class func uptime() -> TimeInterval {
        return ProcessInfo.processInfo.systemUptime
    }
    
    private class func mp_dateFormat(format: String) -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
}


















