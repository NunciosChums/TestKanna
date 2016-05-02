//
//  ViewController.swift
//  TestKanna
//
//  Created by susemi99 on 2016. 4. 25..
//  Copyright © 2016년 susemi99. All rights reserved.
//

import UIKit
import Kanna

class ViewController: UIViewController {
  let IS_FIRST_RUN = "is_first_run"
  var items: [NSURL] = []
  let fileManager = NSFileManager.defaultManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = NSBundle.mainBundle().resourcePath! + "/samples"
    let files = try! fileManager.contentsOfDirectoryAtPath(path)
    
    for file in files {
      let p = path + "/" + file
      print(p)
      
      kml1(p)
      kml2()
      kml3(p)
    }
  }
  
  func kml1(url: String){
    print("============ kml 1 =============")
    let data = NSFileManager.defaultManager().contentsAtPath(url)
    let xml = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding)
  
    for style in xml!.css("Style") {
      let href = style.css("href").text!
      print("00 Style = (\(href))")
    }
    
    for style in xml!.css("style") {
      let href = style.css("href").text!
      print("11 style=(\(href))")
    }
    
    for style in xml!.css("Placemark") {
      let href = style.css("styleUrl").text!
      print("22 styleUrl=(\(href))")
    }
    
    for style in xml!.css("placemark") {
      let href = style.css("styleurl").text!
      print("33 styleurl=(\(href))")
    }
  }
  
  func kml2()
  {
    print("============ kml 2 =============")
    let text = "<Style id='icon-1207-nodesc-highlight'>" +
              "    <IconStyle>" +
              "        <scale>1.1</scale>" +
              "        <Icon>" +
              "            <href>http://www.gstatic.com/mapspro/images/stock/1207-fac-parking.png</href>" +
              "        </Icon>" +
              "    </IconStyle>" +
              "    <LabelStyle>" +
              "        <scale>1.1</scale>" +
              "    </LabelStyle>" +
              "    <BalloonStyle>" +
              "        <text><![CDATA[<h3>$[name]</h3>]]></text>" +
              "    </BalloonStyle>" +
              "</Style>"
    
    let xml = Kanna.XML(xml: text, encoding: NSUTF8StringEncoding)
    
    for style1 in xml!.css("Style") {
      let href = style1.css("href").text!
      print("href=(\(href))")
    }
  }
  
  func kml3(url: String){
    print("============ kml 3 =============")
    let data = NSFileManager.defaultManager().contentsAtPath(url)
    let xml = Kanna.XML(xml: data!, encoding: NSUTF8StringEncoding)

    let namespaces = ["kml": "http://www.opengis.net/kml/2.2"]
    
    for style1 in xml!.css("kml|Style", namespaces: namespaces) {
      let href = style1.css("kml|href", namespaces: namespaces).text!
      print("44 href=(\(href))")
    }
    
    for style1 in xml!.css("kml|style", namespaces: namespaces) {
      let href = style1.css("kml|href", namespaces: namespaces).text!
      print("55 href=(\(href))")
    }
    
    for style in xml!.css("kml|Placemark", namespaces: namespaces) {
      let href = style.css("kml|styleUrl", namespaces: namespaces).text!
      print("66 styleUrl=(\(href))")
    }
    
    for style in xml!.css("kml|placemark", namespaces: namespaces) {
      let href = style.css("kml|styleurl", namespaces: namespaces).text!
      print("77 styleurl=(\(href))")
    }
  }
}

