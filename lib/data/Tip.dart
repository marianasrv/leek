class Tip {
  String title;
  String user;
  String content;

  Tip({this.title, this.user, this.content});
}

List allTips() {
  return [
    Tip(
        title: "Introduction to Pineaple",
        user: 'Susan',
        content: "Who cares about pinapples?"),
    Tip(
        title: "Introduction to Apples",
        user: 'Andrew',
        content: "Who cares about apples?"),
    Tip(
        title: "Introduction to Bananas",
        user: 'John',
        content: "Who cares about bananas?"),
    Tip(
        title: "Introduction to Bananas",
        user: 'Mary',
        content: "Who cares about bananas?"),
    Tip(
        title: "Introduction to Grapes",
        user: 'Wyatt',
        content: "Who cares about grapes?"),
    Tip(
        title: "Introduction to Blueberries",
        user: 'Wyatt',
        content: "Who cares about blueberries?"),
  ];
}
