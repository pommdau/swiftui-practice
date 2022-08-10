//
//  ProfileHost.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/08/02.
//

import SwiftUI

struct ProfileHost: View {
    
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile  // 元のデータを取得して、onDisappearの処理、つまり元のデータに更新する
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                // The EditButton controls the same editMode environment value that you accessed in the previous step.
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())

    }
}
