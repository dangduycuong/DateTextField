//
//  Model.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import Foundation
import SwiftyJSON

class nnn: BaseDataModel1 {
    var country: String?
    var provinces: [Provinces]?
    
    override func mapping(json: JSON) {
        country = json["country"].stringValue
        provinces = [Provinces](byJSON: json["provinces"])
    }
}

class Provinces: BaseDataModel1 {
    var province: String?
    var confirmed: String?
    var recovered: String?
    var deaths: String?
    var active: String?
    
    override func mapping(json: JSON) {
        province = json["province"].stringValue
        confirmed = json["confirmed"].stringValue
        recovered = json["recovered"].stringValue
        deaths = json["deaths"].stringValue
        active = json["active"].stringValue
    }
}

class BaseDataModel1: NSObject, SwiftyJSONMappable {
    
    var message: String?
    
    override init() {
        super.init()
    }
    
    required init?(byJSON json: JSON) {
        super.init()
        mapping(json: json)
    }
    
    required init?(byString string: String, key: String = "") {
        super.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        mapping(json: json)
    }
    
    func mapping(json: JSON) {
        if json.type == .null {
            return
        }
        
        if json["message"].exists() {
            message = json["message"].stringValue
        }
    }
}

class SwityJSONModel: BaseDataModel1 {
    var data: [DDD]?
    
    override func mapping(json: JSON) {
        
    }
}

struct DDD {
    var country: String?
    
    
}

struct DataModel: Codable {
    var message: String?
    var names: [String]?
    var reportDates: [String]?
    
    var data: [DailyReportByCountryNameModel]?
    
    enum CodingKeys: String, CodingKey {
        case message = ""
        case names = "names"
        case reportDates = "reportDates"
    }
}
struct Geometry : Codable {
    var message : String? = nil
    let data : [DailyReportByCountryNameModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case data = ""
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([DailyReportByCountryNameModel].self, forKey: .data)
    }
    
}

protocol SwiftyJSONMappable {
    init?(byJSON json: JSON)
    //    init?(byString string: String, key: String)
}

extension Array where Element: SwiftyJSONMappable {
    
    init(byJSON json: JSON) {
        self.init()
        if json.type == .null { return }
        
        for item in json.arrayValue {
            if let object = Element.init(byJSON: item) {
                self.append(object)
            }
        }
    }
    
    init(byString string: String, key: String = "") {
        self.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        if json.type == .null { return }
        
        for item in json.arrayValue {
            if let object = Element.init(byJSON: item) {
                self.append(object)
            }
        }
    }
}

extension String {
    
    //    func toJSON() -> JSON {
    //        return self.data(using: String.Encoding.utf8).flatMap({ JSON(data: $0) }) ?? JSON(NSNull())
    //    }
    
    func toJSON() -> JSON {
        let json = self.data(using: String.Encoding.utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
        return json
    }
}
