//
//  CalculatorPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class CalculatorPresenter: CalculatorPresenterProtocol {
    // MARK: - Attributes
    weak var view: CalculatorViewProtocol?
    var interactor: CalculatorInputInteractorProtocol?
    var router: CalculatorRouterProtocol?
    let localization = CalculatorLocalization()
    var plans = [Plan]()
    var amount = ""
    // MARK: - Init
    init(view: CalculatorViewProtocol?, interactor: CalculatorInputInteractorProtocol, router: CalculatorRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupPlansTableView()
        interactor?.retrivePlans()
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func amountValueChange(_ amount: String?) {
        self.amount = amount ?? ""
        view?.reloadPlans()
    }
    func config(planCell cell: PlanCellProtocol, atIndex index: Int) {
        let plan = plans[index]
        let amount = Int(self.amount) ?? 0
        let totalAmount = Double(amount + ((amount * plan.percentage) / 100))
        let monthAmount = ceil( totalAmount / Double(plan.months))
        cell.setPlan(amount: String(monthAmount), month: plan.name)
    }
    var numberOfPlans: Int {
       let plansCount = amount.isEmpty ? 0 : plans.count
       return plansCount
    }
}
// MARK: - CalculatorOutputInteractorProtocol Implementation
extension CalculatorPresenter: CalculatorOutputInteractorProtocol {
    func onRetrivePlansSuccess(_ plans: [Plan]) {
        self.plans = plans
    }
}
