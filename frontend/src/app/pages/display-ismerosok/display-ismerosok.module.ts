import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayIsmerosokComponent } from './display-ismerosok.component';
import { MatCardModule } from '@angular/material/card';
import { RouterModule } from '@angular/router';



@NgModule({
  declarations: [DisplayIsmerosokComponent],
  imports: [
    CommonModule,
    MatCardModule,
    RouterModule
  ],
  exports: [DisplayIsmerosokComponent]
})
export class DisplayIsmerosokModule { }
