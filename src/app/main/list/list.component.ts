import { AfterViewInit, Component, OnInit, ViewChild } from "@angular/core";
import { MdSidenav } from "@angular/material";

@Component({
  selector: "app-list",
  templateUrl: "./list.component.html",
  styleUrls: ["./list.component.scss"]
})
export class ListComponent implements OnInit, AfterViewInit {

  @ViewChild("sidenav")
  side: MdSidenav;

  constructor() {
  }

  ngOnInit() {
  }

  ngAfterViewInit(): void {
  }

}
