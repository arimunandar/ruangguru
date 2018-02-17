//
//  Clients.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Alamofire

class Clients {
	
	var baseURL: String = "https://opentdb.com"
	var route: String = ""
	var method: HTTPMethod = .get
	var headers: HTTPHeaders = [:]
	var encoding: ParameterEncoding = URLEncoding.queryString
	var withLoading: Bool = true
	var token: String {
		let defaults = UserDefaults.standard
		let token = defaults.string(forKey: "token")
		return token ?? ""
	}
	
	enum Client {
		case category
		case question
	}
	
	init(client: Client) {
		switch client {
		case .category:
			self.method = .post
			self.route = "\(self.baseURL)/api_category.php"
			self.encoding = JSONEncoding.default
			self.withLoading = true
		case .question:
			self.method = .get
			self.route = "\(self.baseURL)/api.php"
			self.encoding = URLEncoding.queryString
			self.withLoading = true
		}
	}
}
