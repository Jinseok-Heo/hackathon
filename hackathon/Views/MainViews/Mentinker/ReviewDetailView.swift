//
//  ReviewDetailView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI
import Combine

class ReviewDetailViewModel: ObservableObject {
    
    let mento: Mento?
    
    @Published
    var reviews: Reviews
    @Published
    var cancellabels = Set<AnyCancellable>()
    
    public init(mento: Mento?) {
        self.mento = mento
        self.reviews = []
        getReviews()
    }
    
    private func getReviews() {
        if let mento = mento {
            MatchingAPIService.reviewDetail(mentoId: mento.id)
                .sink { result in
                    switch result {
                    case .finished:
                        print("Get review success")
                    case .failure(let error):
                        print("Ger review failed")
                        NSLog(error.localizedDescription)
                    }
                } receiveValue: { reviews in
                    self.reviews = reviews
                    print(reviews)
                }
                .store(in: &cancellabels)
        }
    }
}

struct ReviewCard: View {
    
    let review: Review
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color("secondColor").opacity(0.3))
            VStack(alignment: .leading) {
                HStack {
                    Text(review.nickName)
                        .font(FontManager.font(size: 20, weight: .bold))
                    ratingField
                }
                Text(review.content)
                    .font(FontManager.font(size: 15, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundColor(Color(hex: "#191919"))
        }
        .frame(height: 100)
    }
    
    private var ratingField: some View {
        HStack {
            ForEach(1..<6) { idx in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Int(review.rating)! < idx ? Color(hex: "#CECECE") : Color("secondColor"))
            }
        }
    }
}

struct ReviewDetailView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var reviewDetailVM: ReviewDetailViewModel
    
    init(mento: Mento?) {
        self._reviewDetailVM = StateObject(wrappedValue: ReviewDetailViewModel(mento: mento))
    }
    
    var body: some View {
        VStack {
            headerView
                .padding(.bottom, 20)
            ScrollView {
                VStack {
                    titleView
                    ForEach(reviewDetailVM.reviews, id: \.self) { review in
                        ReviewCard(review: review)
                    }
                }
            }
            Spacer()
        }
        .padding([.leading, .trailing], 22)
        .navigationBarHidden(true)
    }
    
}

extension ReviewDetailView {
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 10, height: 17)
                        .foregroundColor(Color(hex: "#191919"))
                }
                Text("돌아가기")
                    .font(FontManager.font(size: 18, weight: .semibold))
                    .foregroundColor(Color(hex: "#191919"))
                Spacer()
            }
            .padding(.bottom, 26)
        }
    }
    
    private var titleView: some View {
        Text("리뷰 보기")
            .font(FontManager.font(size: 26, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
