//
//  ReviewDetailView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI

class ReviewDetailViewModel: ObservableObject {
    
    let mento: Mento?
    
    public init(mento: Mento?) {
        self.mento = mento
        
        getReviews()
    }
    
    private func getReviews() {
        if let mento = mento {
            MatchingAPIService.reviewDetail(mentoId: mento.id) { response in
                if let data = response.data {
                    print(String(data: data, encoding: .utf8))
                } else {
                    print("Failed get review detail")
                }
            }
        }
    }
    
}

struct ReviewDetailView: View {
    
    @StateObject
    var reviewDetailVM: ReviewDetailViewModel
    
    init(mento: Mento?) {
        self._reviewDetailVM = StateObject(wrappedValue: ReviewDetailViewModel(mento: mento))
    }
    
    var body: some View {
        VStack {
            
        }
    }
    
}
