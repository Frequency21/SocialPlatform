import { DisplayPostsModule } from './../display-posts/display-posts.module';
import { MatButtonModule } from '@angular/material/button';
import { MatIcon, MatIconModule } from '@angular/material/icon';
import { ModalPosztComponent } from './../modal-poszt/modal-poszt.component';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatCardModule } from '@angular/material/card';
import { DisplayUserComponent } from './display-user.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatButton } from '@angular/material/button';



@NgModule({
  declarations: [DisplayUserComponent],
  entryComponents: [ModalPosztComponent],
  imports: [
    DisplayPostsModule,
    CommonModule,
    MatCardModule,
    MatToolbarModule,
    MatIconModule,
    MatButtonModule,
    RouterModule
  ],
  exports: [DisplayUserComponent]
})
export class DisplayUserModule { }
