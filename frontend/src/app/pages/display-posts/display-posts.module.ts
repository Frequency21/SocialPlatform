import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayPostsComponent } from './display-posts.component';
import { PosztModule } from '../poszt/poszt.module';



@NgModule({
  declarations: [DisplayPostsComponent],
  imports: [
    CommonModule,
    PosztModule
  ],
  exports: [DisplayPostsComponent]
})
export class DisplayPostsModule { }
