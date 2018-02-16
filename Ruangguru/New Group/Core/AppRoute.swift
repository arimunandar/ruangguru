//
//  AppRoute.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject

class AppRouter {

	fileprivate class func setup() -> Assembler {
		let assemble = Assembler()
		 assemble.apply(assemblies: [CategoryAssembly()])
		return assemble
	}
	
	class func present() -> Resolver {
		return AppRouter.setup().resolver
	}
}
