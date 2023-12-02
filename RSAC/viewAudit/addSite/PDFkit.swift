//
//  PDFkit.swift
//  RSAC
//
//  Created by John on 22/11/2023.
//

import Foundation
import PDFKit



extension viewSiteSnaps{
    

  
//    class PDFCreator: NSObject {
//        let title: String
//        let body: String
//        let image: String
//
//        
//        init(title: String, description:String, image:String) {
//            self.title = title
//            self.body = description
//            self.image = image
//          
//        }
//        
        

    struct PDFCreatorData {
        
        let title: String
        let body: String
        let image: String
        
        
        init(title: String, description:String, image:String) {
            self.title = title
            self.body = description
            self.image = image
            
        }
    }
        
        func createPDF() -> Data {
          // 1
          let pdfMetaData = [
            kCGPDFContextCreator: "RSAC",
            kCGPDFContextAuthor: "RSAC",
            kCGPDFContextTitle: title
          ]
          let format = UIGraphicsPDFRendererFormat()
          format.documentInfo = pdfMetaData as [String: Any]
          
          // 2
          let pageWidth = 8.5 * 72.0
          let pageHeight = 11 * 72.0
          let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
           
          
          // 3
          let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
          // 4
          let data = renderer.pdfData { (context) in
            // 5
            //create multiple pages based on data
          
           
              print("data123:\(self.dataStruct)")
              for x in dataStruct{
                  context.beginPage()
                  
                  // 6
                  let titleData = addTitle(pageRect: pageRect, titleData: x.title) // returns height y-coordinate of title
                  self.addImage(pageRect: pageRect, imageTop: addBodyText(pageRect: pageRect, textTop: titleData + 18.0, bodyData: x.body), imageData: x.image)
              }
            



          }
          
          return data
        }
        
        func addTitle(pageRect: CGRect, titleData:String) -> CGFloat {
            // 1
            let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
            // 2
            let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
            let attributedTitle = NSAttributedString(string: titleData, attributes: titleAttributes)
            // 3
            let titleStringSize = attributedTitle.size()
            // 4
            let titleStringRect = CGRect(x: pageRect.width / 2.0,
                                         y: 36, width: titleStringSize.width,
                                         height: titleStringSize.height)
            // 5
            attributedTitle.draw(in: titleStringRect)
            // 6
            return titleStringRect.origin.y + titleStringRect.size.height
        }
        
    func addBodyText(pageRect: CGRect, textTop: CGFloat, bodyData:String) -> CGFloat{
          // 1
          let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
          // 2
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.alignment = .left
          paragraphStyle.lineBreakMode = .byWordWrapping
          // 3
          let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
          ]
          let attributedText = NSAttributedString(string: bodyData, attributes: textAttributes)
          let titleStringSize = attributedText.size()
          // 4
          let textRect = CGRect(x: pageRect.width / 2.0, y: textTop, width: pageRect.width/2 - 20,
                                height: pageRect.height - textTop - pageRect.height / 5.0)
          attributedText.draw(in: textRect)

          return textRect.origin.y + textRect.size.height
        }


    func addImage(pageRect: CGRect, imageTop: CGFloat, imageData: String) {
          // 1
          
          let maxHeight = pageRect.height * 0.4
          let maxWidth = pageRect.width * 0.8
          // 2
          let aspectWidth = maxWidth
          let aspectHeight = maxHeight
          let aspectRatio = min(aspectWidth, aspectHeight)
          // 3
          let scaledWidth =  aspectRatio
          let scaledHeight =  aspectRatio
          // 4
          let imageX = (pageRect.width - scaledWidth) / 2.0
          let imageRect = CGRect(x: imageX, y: imageTop,
                                 width: scaledWidth, height: scaledHeight)
          // 5
          
  
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: imageData)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        //self?.myImage = image
                        image.draw(in: imageRect)
                        
                    }
                }
            }
        }

        }

        
    
    
}
