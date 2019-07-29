//
//  EliqOnboardingFactory.swift
//  EliqModels
//
//  Created by MS on 2019-07-29.
//
import EliqModels

open class EliqOnboardingFactory{
    
    public static func getViewFor(onboardingModel:OnboardingModel) -> EliqOnboardingParentView{
        if onboardingModel.links == nil{
            let view = EliqOnboardingView(frame: CGRect.zero)
            view.viewModel = onboardingModel
            return view
        }else{
            let view = EliqOnboardingWithButtonView(frame: CGRect.zero)
            view.viewModel = onboardingModel
            return view
        }
    }
}
