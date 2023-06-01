class OnBoardModel {
  String? imageName;
  String? boldText;
  String? normalText;

  OnBoardModel({required this.imageName, required this.boldText, required this.normalText});
}

List<OnBoardModel> onBoardScreens = [
  OnBoardModel(
    imageName: "assets/images/onboard1.png",
    boldText: "onboarding_headingText1",
    normalText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  ),
  OnBoardModel(
    imageName: "assets/images/onboard2.png",
    boldText: "onboarding_headingText2",
    normalText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  ),
  OnBoardModel(
    imageName: "assets/images/onboard3.png",
    boldText: "onboarding_headingText3",
    normalText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  )
];
