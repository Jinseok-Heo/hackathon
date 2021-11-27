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
    
    @Published
    var didSuccess: Bool
    
    public init(meeting: Schedule) {
        self.rating = 0
        self.content = ""
        self.meeting = meeting
        self.didSuccess = false
    }
    
    public func post() {
        MatchingAPIService.postReview(rating: rating, matchingId: meeting.matchingId, mentoId: meeting.mentoId, content: content) { response in
            switch response.result {
            case .success:
                print("review post success")
                ReviewFilter.postedReview.append(self.meeting)
                self.didSuccess = true
            case .failure(let error):
                print("review post failed")
                NSLog(error.localizedDescription)
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
    
    @Binding
    var didSuccess: Bool
    
    init(meeting: Schedule, didSuccess: Binding<Bool>) {
        self.meeting = meeting
        self._reviewPostingVM = StateObject(wrappedValue: ReviewPostingViewModel(meeting: meeting))
        self._didSuccess = didSuccess
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
        .alert(isPresented: $reviewPostingVM.didSuccess) {
            Alert(title: Text("후기가 작성되었습니다"), dismissButton: .default(Text("확인")) {
                self.didSuccess = true
                self.presentationMode.wrappedValue.dismiss()
            })
        }
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
            reviewPostingVM.post()
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
