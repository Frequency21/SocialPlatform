import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayGroupsComponent } from './display-groups.component';



@NgModule({
  declarations: [DisplayGroupsComponent],
  imports: [
    CommonModule,
    MatCardModule,
    RouterModule
  ],
  exports: [DisplayGroupsComponent]
})
export class DisplayGroupsModule { }
