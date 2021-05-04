import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayUsersComponent } from './display-users.component';



@NgModule({
  declarations: [ DisplayUsersComponent ],
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule
  ],
  exports: [DisplayUsersComponent]
})
export class DisplayUsersModule { }
