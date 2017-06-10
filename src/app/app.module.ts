import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PageNotFoundComponent } from './page-not-found.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule, MdButtonModule, MdToolbarModule } from '@angular/material';
import { MainComponent } from './main/main.component';
import { ListComponent } from './main/list/list.component';
import { SidenavComponent } from './main/sidenav/sidenav.component';

@NgModule({
  declarations: [
    AppComponent,
    PageNotFoundComponent,
    MainComponent,
    ListComponent,
    SidenavComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
