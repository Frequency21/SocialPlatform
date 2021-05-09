import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatButton } from '@angular/material/button';
import { MatToolbarModule } from '@angular/material/toolbar';
import { RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayGroupComponent } from './display-group.component';
import { MatCardModule } from '@angular/material/card';



@NgModule({
  declarations: [DisplayGroupComponent],
  imports: [
    CommonModule,
    MatToolbarModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule
  ],
  exports: [DisplayGroupComponent]
})
export class DisplayGroupModule { }
