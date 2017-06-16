//
//  UIImageMST.swift
//  MSTTools_Swift
//
//  Created by 张宇豪 on 2017/6/7.
//  Copyright © 2017年 张宇豪. All rights reserved.
//

import UIKit

fileprivate func DegreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat.pi / 180
}

fileprivate func RadiansToDegrees(_ radians: CGFloat) -> CGFloat {
    return radians * 180 / CGFloat.pi
}

extension UIImage {
    /// 从资源文件中获取图像
    ///
    /// - Parameter fileName: 文件名称
    /// - Returns: 图片
    class func mst_newImageFromResource(fileName: String) -> UIImage? {
        let imageFile: String = "\(String(describing: Bundle.main.resourcePath))/\(fileName)"
        
        var image: UIImage?
        image = UIImage(contentsOfFile: imageFile)
        
        return image
    }
    
    /// 根据颜色创建图片颜色
    ///
    /// - Parameter color: 颜色
    /// - Returns: 返回 1*1 的图片
    class func mst_createImage(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 截取View为图片
    ///
    /// - Parameter view: 被截取的View
    /// - Returns: 截取图片
    class func mst_image(view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 根据 rect 截取图片中的部分
    ///
    /// - Parameter rect: 截取区域
    /// - Returns: 截取图片
    func mst_image(rect: CGRect) -> UIImage {
        let imageRef: CGImage = cgImage!.cropping(to: rect)!
        
        return UIImage(cgImage: imageRef)
    }
    
    /// 等比例对图片进行缩放至最小尺寸
    ///
    /// - Parameter targetSize: 目标尺寸
    /// - Returns: 缩放后图片
    func mst_imageByScalingProportionally(toMinimumSize targetSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        
        let targetWidth: CGFloat = targetSize.width
        let targetHeight: CGFloat = targetSize.height
        
        var scaleFactor: CGFloat = 0
        var scaledWidth: CGFloat = targetWidth
        var scaledHeight: CGFloat = targetHeight
        
        var thumbnailPoint: CGPoint = CGPoint.zero
        
        if (!size.equalTo(targetSize)) {
            let widthFactor: CGFloat = targetWidth / width
            let heightFactor: CGFloat = targetHeight / height
            
            if (widthFactor > height) {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            scaledWidth  = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            } else if (widthFactor < heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect: CGRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (newImage == nil) {
            print("Could not scale image to minimum size.")
        }
        
        return newImage
    }
    
    /// 等比例对图片缩放至指定尺寸
    ///
    /// - Parameter targetSize: 目标尺寸
    /// - Returns: 缩放后图片
    func mst_imageByScalingProportionally(toSize targetSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        
        let width: CGFloat = size.width
        let height: CGFloat = size.height
        
        let targetWidth: CGFloat = targetSize.width
        let targetHeight: CGFloat = targetSize.height
        
        var scaleFactor: CGFloat = 0.0
        var scaledWidth: CGFloat = targetWidth
        var scaledHeight: CGFloat = targetHeight
        
        var thumbnailPoint: CGPoint = CGPoint.zero
        
        if (!size.equalTo(targetSize)) {
            
            let widthFactor: CGFloat = targetWidth / width
            let heightFactor: CGFloat = targetHeight / height
            
            if (widthFactor < heightFactor) {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            
            if (widthFactor < heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if (widthFactor > heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }

        UIGraphicsBeginImageContext(targetSize);
        
        var thumbnailRect: CGRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width  = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (newImage == nil) {
            print("Could not scale image to size.")
        }
        
        return newImage
    }
    
    /// 将图片压缩至指定宽度
    ///
    /// - Parameter dedineWidth: 目标宽度
    /// - Returns: 压缩后图片
    func mst_imageCompress(width defineWidth: CGFloat) -> UIImage? {
        var newImage: UIImage?

        let width: CGFloat = self.size.width
        let height: CGFloat = self.size.height
        
        let targetWidth: CGFloat = defineWidth
        let targetHeight: CGFloat = height / (width / targetWidth)
        
        let size = CGSize(width: targetWidth, height: targetHeight)
        var scaleFactor: CGFloat = 0.0
        
        var scaledWidth: CGFloat = targetWidth
        var scaledHeight: CGFloat = targetHeight
        
        var thumbnailPoint: CGPoint = CGPoint.zero
        
        if (!self.size.equalTo(size)) {
            let widthFactor: CGFloat = targetWidth / width
            let heightFactor: CGFloat = targetHeight / height
            if (widthFactor > heightFactor) {
                scaleFactor = widthFactor
            } else{
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            } else if (widthFactor < heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(size)
        var thumbnailRect: CGRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if (newImage == nil) {
            print("Compress image for width fail.")
        }
        
        return newImage
    }
    
    /// 将图片进行旋转(角度制)
    ///
    /// - Parameter degrees: 旋转角度
    /// - Returns: 旋转后图片
    func mst_imageRotated(degrees: CGFloat) -> UIImage {
        // 首先计算旋转之后的视图的尺寸
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: DegreesToRadians(degrees))
        rotatedViewBox.transform = t
        
        let rotatedSize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        
        // 将定点移动到图片中间
        bitmap.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
        
        // 旋转
        bitmap.rotate(by: DegreesToRadians(degrees))
        
        // 得到旋转之后的图片
        bitmap.scaleBy(x: 1, y: -1)
        bitmap.draw(cgImage!, in: CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// 将图片进行旋转(角度制)
    ///
    /// - Parameter radians: 旋转角度
    /// - Returns: 旋转后图片
    func mst_imageRotated(radians: CGFloat) -> UIImage {
        return mst_imageRotated(degrees: RadiansToDegrees(radians))
    }
    
    /// 为图片添加毛玻璃效果
    ///
    /// - Parameter blur: 效果参数
    /// - Returns: 结果图片
    func mst_coreBlur(blurNumber blur: CGFloat) -> UIImage {
        let context: CIContext = CIContext(options: nil)
        let inputImage: CIImage = CIImage(cgImage: cgImage!)
        
        // 设置filter
        let filter: CIFilter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(blur, forKey: "inputRadius")
        
        // 模糊图片
        let result: CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let outImage:CGImage = context.createCGImage(result, from: result.extent)!
        let blurImage: UIImage = UIImage(cgImage: outImage)
        
        return blurImage
    }
    
    /// 根据指定点对图片进行拉伸
    ///
    /// - Parameter point: 目标点
    /// - Returns: 拉伸图片
    func mst_stretchImage(capPoint point: CGPoint) -> UIImage {
        let streImage: UIImage = stretchableImage(withLeftCapWidth: Int(point.x), topCapHeight: Int(point.y))
        return streImage
    }
    
    /// 将图片截取为正方形
    ///
    /// - Returns: 截取后图片
    func mst_cropedImageToSquare() -> UIImage {
        var cropRect: CGRect!
        
        if size.height > size.width {
            cropRect = CGRect(x: 0, y: (size.height - size.width)/2, width: size.width, height: size.width)
        } else {
            cropRect = CGRect(x: (size.width - size.height)/2, y: 0, width: size.height, height: size.height)
        }
        
        let imageRef: CGImage = (cgImage?.cropping(to: cropRect))!
        let cropImage: UIImage = UIImage(cgImage: imageRef)
        
        return cropImage
    }
    
    /// 修正图片方向
    ///
    /// - Returns: 修正后图片
    func mst_fixOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi/2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat.pi/2)
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: (cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (cgImage?.colorSpace)!, bitmapInfo: (cgImage?.bitmapInfo.rawValue)!)!
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        let cgImg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgImg)
        
        return img
    }
}
