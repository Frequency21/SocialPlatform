import { ModalKategoryComponent } from './../modal-kategory/modal-kategory.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CategoriesComponent } from './categories.component';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { RouterModule } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';
import { DisplayPostsModule } from '../display-posts/display-posts.module';



@NgModule({
  declarations: [
    CategoriesComponent
  ],
  entryComponents: [ModalKategoryComponent],
  imports: [
    DisplayPostsModule,
    CommonModule,
    MatCardModule,
    MatToolbarModule,
    MatIconModule,
    MatButtonModule,
    CommonModule,
    MatCardModule,
    MatButtonModule,
    RouterModule
  ],
  exports: [ CategoriesComponent ]
})
export class CategoriesModule { }
