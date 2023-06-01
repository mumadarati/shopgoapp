class NotificationModel {
  String? id;
  String? image;
  String? title;
  String? description;

  NotificationModel({this.id, this.image, this.title, this.description});
}

var notificationsList = [
  NotificationModel(
    id: "1",
    image: "not_1.png",
    title: "ULTRABOOST 22 COLD",
    description: "The adidas Ultraboost set the standard for comfort and performance in a running shoe when it debuted in 2015."
        " Every new version of the shoe raises the bar even higher and this model is no exception. Designed for cold weather"
        " runs, these running shoes keep your feet warm with COLD.RDY technology. The energy-converting BOOST midsole glows "
        "in the dark with its reflective structure. ",
  ),
  NotificationModel(
    id: "2",
    image: "not_2.png",
    title: "FUTURE ICONS 3",
    description: "Simplicity is the best strategy. With its strong and simple lines, this T-shirt looks as good with jeans"
        " as it does with jogger pants. Made from soft cotton jersey fabric, it lets you move freely. "
        "As long as you want to move, of course. The choice is yours. Our cotton products support sustainable cotton farming.",
  ),
  NotificationModel(
    id: "3",
    image: "not_3.png",
    title: "FLOOCE X-CITY HOODIE",
    description: "Changes in air temperature are part of the game; All runners know this very well."
        " Wear this hoodie to feel good for miles. The model, which prevents the arms from slipping with its thumb holes, "
        "allows you to comfortably carry your music player and other small items with its zippered pocket on the arm."
        " Just put on your hood for protection when the storm hits.",
  ),
  NotificationModel(
    id: "4",
    image: "not_4.png",
    title: "CLASSICS MEN'S JACKET",
    description: "Our Classics collection is full of simple items. Keeping up with the rainCELL, windCELL, and warmCELL "
        "technologies that provide protection against external factors and fashion, this jacket is the best friend of cold "
        "weather. PUMA's technical material structure is designed to protect you against rainy weather and stay dry. ",
  ),
];
