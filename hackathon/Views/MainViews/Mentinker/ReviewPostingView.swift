//
//  ReviewPostingView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI

class ReviewPostingViewModel: ObservableObject {
    
    @Published
    var meeting: Schedule
    
    @Published
    var rating: Int
    @Published
    var content: String
    
    public init(meeting: Schedule) {

        self.rating = 0
        self.content = ""
        self.meeting = meeting
    }
    
    public func post() {
        MatchingAPIService.postReview(rating: rating, matchingId: "2", mentoId: "1", content: content) { response in
            switch response.result {
            case .success:
                print("review post success")
            case .failure(let error):
                print("review post failed")
            }
        }
    }
    
}

struct ReviewPostingView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var reviewPostingVM: ReviewPostingViewModel
    
    let meeting: Schedule
    
    init(meeting: Schedule) {
        self.meeting = meeting
        self._reviewPostingVM = StateObject(wrappedValue: ReviewPostingViewModel(meeting: meeting))
    }
    
    var body: some View {
        VStack {
            titleView
                .padding(.bottom, 30)
            ScrollView {
                VStack {
                    profileView
                        .padding(.bottom, 20)
                    ratingSelectionField
                        .padding(.bottom, 30)
                    contentView
                        .padding(.bottom, 14)
                }
            }
            saveButton
        }
        .padding([.leading, .trailing], 22)
        .navigationBarHidden(true)
    }
}

extension ReviewPostingView {
    
    private var titleView: some View {
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
            Text("리뷰 작성")
                .font(FontManager.font(size: 26, weight: .bold))
        }
    }
    
    private var profileView: some View {
        Image(uiImage: meeting.profileImage.toImage()!)
            .resizable()
            .frame(width: 130, height: 130)
            .clipShape(Circle())
    }
    
    private var ratingSelectionField: some View {
        VStack {
            Text("평점 입력하기")
                .font(FontManager.font(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "#777777"))
            HStack {
                ForEach(1..<6) { idx in
                    Button {
                        reviewPostingVM.rating = idx
                    } label: {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(reviewPostingVM.rating < idx ? Color(hex: "#CECECE") : Color("secondColor"))
                    }
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Text("후기 작성하기")
                .font(FontManager.font(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "#777777"))
            TextEditor(text: $reviewPostingVM.content)
                .font(FontManager.font(size: 15, weight: .regular))
                .disableAutocorrection(true)
                .cornerRadius(4)
                .colorMultiply(Color(hex: "#ECECEC"))
                .frame(minHeight: 250)
        }
    }
    
    private var saveButton: some View {
        Button {
            // save
        } label: {
            Text("저장")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("secondColor")))
        }
    }
    
}
