//
//  ProfileView.swift
//  Expenses
//
//  Created by Vito Stamatti on 6/12/23.
//

import SwiftUI
import SwiftData
import Photos

struct ProfileView: View {
    @Query var profiles:[UserProfile]
    
    var body: some View {
        if let userProfile = profiles.first {
            ProfileInfoView(userProfile: userProfile)
        } else {
            ContentUnavailableView(label: {
                Label("User Information not Available", systemImage: "person.slash")
            }, description: {
                Text("Try again later of contact help center")
            })
            
        }
        
    }
}

struct ProfileInfoView : View{
    @State var showEditPage:Bool = false
    
    var userProfile:UserProfile
    
    var body: some View {
        VStack(spacing:16) {
            
            if let data = userProfile.imageData  {
                if let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                }
            } else {
                Image(systemName: "person")
                    .imageScale(.large)
                    .frame(width: 60, height: 60)
                    .background(.thinMaterial)
                    .clipShape(Circle())
                
            }
            
            Text(userProfile.name)
                .font(.title)
            
            Button {
                showEditPage.toggle()
            } label:{
                Text("Edit")
                    .frame(width: 60)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showEditPage, content: {
            EditProfileSheetView(userProfile: userProfile)
        })
    }
    
}

struct EditProfileSheetView :View {
    @Environment(\.dismiss) var dismiss
    @Bindable var userProfile:UserProfile
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Text("Edit Profile")
                    .font(.title2)
                    .padding()
                
                Spacer()
                
            }
            .padding()
            
            Form {
                TextField("User Name",text: $userProfile.name)
            }
        
            Button {
                dismiss()
                
            } label: {
                Text("Done")
                    .frame(width: 60)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }

        }
    }
    
}

#Preview {
    ProfileView()
        .appDataContainer(inMemory: true)
}

#Preview("No user information") {
    ProfileView()
}
