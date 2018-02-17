//
//  BaseClient.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Alamofire
import SwiftyJSON
import NotificationBannerSwift
import NVActivityIndicatorView

class Connectivity {
	class func isConnectedToInternet() -> Bool {
		return NetworkReachabilityManager()!.isReachable
	}
}

class BaseClient<Element: BaseEntity> {
	
	private let activityData = ActivityData(size: CGSize(width: 40, height: 40), type: NVActivityIndicatorType.lineScalePulseOut)
	
	class func fetchData(_ params: Parameters = [:], client: Clients, onSuccess: @escaping (Element) -> Void, onFailure: (() -> Void)?) {
		
		if client.withLoading {
			NVActivityIndicatorPresenter.sharedInstance.startAnimating(BaseClient().activityData)
		}
		
		if Connectivity.isConnectedToInternet() {
			DispatchQueue.main.async {
				Alamofire.request(client.route, method: client.method, parameters: params, encoding: client.encoding, headers: client.headers).responseJSON { response in
					
					NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
					
					switch response.result {
					case .success(let value):
						let data = JSON(value)
						onSuccess(Element(json: data))
					case .failure:
						BaseClient.setAlert(title: "Warning!", message: "Internal Server Error", style: .danger)
					}
				}
			}
		} else {
			NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
			BaseClient.setAlert(title: "Warning!", message: "No Internet Connection.", style: .danger)
		}
	}
	
	private class func setAlert(title: String, message: String, style: BannerStyle = .none) {
		let banner = NotificationBanner(title: title, subtitle: message, style: style)
		banner.duration = 2.0
		banner.show()
	}
}
