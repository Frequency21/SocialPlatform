import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayUsersComponent } from './display-users.component';
import { DisplayUserModule } from '../display-user/display-user.module';



@NgModule({
  declarations: [ DisplayUsersComponent ],
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    DisplayUserModule
  ],
  exports: [DisplayUsersComponent]
})
export class DisplayUsersModule { }
