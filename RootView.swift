import SwiftUI

struct RootView: View {
    @AppStorage("aimcheat.loggedIn") private var loggedIn = false
    var body: some View {
        Group { loggedIn ? AnyView(DashboardView()) : AnyView(LoginView()) }
            .preferredColorScheme(.light)
    }
}

struct LoginView: View {
    @AppStorage("aimcheat.loggedIn") private var loggedIn = false
    @State private var username = ""
    @State private var code = ""
    @State private var error: String?

    var body: some View {
        ZStack {
            AIMTheme.background.ignoresSafeArea()
            VStack(spacing: 18) {
                Spacer()
                BrandMark()
                Text("AIMCHEAT").font(.system(size: 29, weight: .heavy, design: .rounded)).foregroundStyle(AIMTheme.blue)
                Text("Chào mừng bạn đến với tiện ích AIMCHEAT").font(.subheadline).foregroundStyle(AIMTheme.muted)
                    .multilineTextAlignment(.center)
                TextField("Tên người dùng", text: $username)
                    .textInputAutocapitalization(.never).autocorrectionDisabled()
                    .padding(16).background(.white, in: RoundedRectangle(cornerRadius: 14))
                SecureField("Mã truy cập demo", text: $code).keyboardType(.numberPad)
                    .padding(16).background(.white, in: RoundedRectangle(cornerRadius: 14))
                Button("ĐĂNG NHẬP") {
                    guard !username.trimmingCharacters(in: .whitespaces).isEmpty, code == "1234" else {
                        error = "Nhập tên bất kỳ và mã demo 1234."; return
                    }
                    loggedIn = true
                }.buttonStyle(PrimaryButtonStyle())
                if let error { Text(error).font(.footnote).foregroundStyle(.red) }
                Text("Bản thử nghiệm • Mã demo: 1234").font(.caption).foregroundStyle(AIMTheme.muted)
                Spacer(); Spacer()
            }.padding(.horizontal, 26)
        }
    }
}

struct DashboardView: View {
    @AppStorage("aimcheat.feature1") private var feature1 = false
    @AppStorage("aimcheat.feature2") private var feature2 = false
    @AppStorage("aimcheat.feature3") private var feature3 = false
    @AppStorage("aimcheat.loggedIn") private var loggedIn = true
    @State private var info = false
    @State private var update = false

    var body: some View {
        NavigationStack {
            ZStack {
                AIMTheme.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 14) {
                        HStack(spacing: 13) {
                            BrandMark(size: 56)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("AIMCHEAT USER").font(.headline).foregroundStyle(AIMTheme.ink)
                                Text("Bảng điều khiển tiện ích").font(.subheadline).foregroundStyle(AIMTheme.muted)
                            }
                            Spacer()
                            Circle().fill(.green).frame(width: 9, height: 9)
                            Text("LOCAL").font(.caption2.bold()).foregroundStyle(AIMTheme.muted)
                        }.padding(16).background(.white, in: RoundedRectangle(cornerRadius: 20))

                        FeatureCard(title: "Tiện ích 01", detail: "Công tắc mẫu • lưu trên thiết bị", enabled: $feature1)
                        FeatureCard(title: "Tiện ích 02", detail: "Không điều khiển ứng dụng khác", enabled: $feature2)
                        FeatureCard(title: "Tiện ích 03", detail: "Có thể tùy biến sau", enabled: $feature3)

                        Button { info = true } label: { Label("THÔNG TIN ỨNG DỤNG", systemImage: "info.circle") }
                            .buttonStyle(PrimaryButtonStyle())
                        Button { update = true } label: { Label("KIỂM TRA CẬP NHẬT", systemImage: "arrow.clockwise") }
                            .buttonStyle(PrimaryButtonStyle())
                        Button(role: .destructive) { loggedIn = false } label: {
                            Label("ĐĂNG XUẤT", systemImage: "rectangle.portrait.and.arrow.right")
                                .frame(maxWidth: .infinity, minHeight: 48)
                        }
                        Text("AIMCHEAT • Version 1.0.0").font(.caption).foregroundStyle(AIMTheme.muted)
                    }.padding(18)
                }
            }
            .navigationTitle("AIMCHEAT").navigationBarTitleDisplayMode(.inline)
            .alert("AIMCHEAT", isPresented: $info) {
                Button("Đóng", role: .cancel) {}
            } message: {
                Text("Phiên bản 1.0.0\niOS • SwiftUI\nCác công tắc chỉ lưu tùy chọn cục bộ.")
            }
            .alert("Kiểm tra cập nhật", isPresented: $update) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Bạn đang dùng phiên bản 1.0.0. Chưa cấu hình máy chủ cập nhật.")
            }
        }
    }
}

struct FeatureCard: View {
    let title: String
    let detail: String
    @Binding var enabled: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(title).font(.headline).foregroundStyle(AIMTheme.ink)
            Text(detail).font(.caption).foregroundStyle(AIMTheme.muted)
            Toggle("BẬT CHỨC NĂNG", isOn: $enabled).font(.subheadline.weight(.semibold)).tint(AIMTheme.blue)
        }.padding(16).background(.white, in: RoundedRectangle(cornerRadius: 18))
    }
}
