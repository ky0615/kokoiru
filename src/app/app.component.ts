import { AfterViewInit, Component, ViewChild } from '@angular/core';
import { MdSidenav } from '@angular/material';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styles: []
})
export class AppComponent implements AfterViewInit {

  @ViewChild('sidenav')
  side: MdSidenav;

  ngAfterViewInit(): void {

  };
}
