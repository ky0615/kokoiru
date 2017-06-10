import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PageNotFoundComponent } from './page-not-found.component';
import { MainComponent } from './main/main.component';
import { ListComponent } from './main/list/list.component';

const routes: Routes = [
  {
    path: '', // TODO: login page
    redirectTo: 'list',
    pathMatch: 'full'
  },
  {
    path: 'list',
    component: MainComponent,
    children: [{
      path: '',
      component: ListComponent
    }]
  },
  {
    path: '**',
    component: PageNotFoundComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
