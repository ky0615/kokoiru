import { KokoiruPage } from "./app.po";

describe("kokoiru App", () => {
  let page: KokoiruPage;

  beforeEach(() => {
    page = new KokoiruPage();
  });

  it("should display welcome message", () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual("Welcome to app!!");
  });
});
