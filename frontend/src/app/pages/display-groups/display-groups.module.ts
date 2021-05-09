import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ModalGroupComponent } from './../modal-group/modal-group.component';
import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DisplayGroupsComponent } from './display-groups.component';



@NgModule({
  declarations: [DisplayGroupsComponent],
  entryComponents: [ModalGroupComponent],
  imports: [
    CommonModule,
    MatCardModule,
    RouterModule,
    MatDialogModule
  ],
  exports: [DisplayGroupsComponent]
})
export class DisplayGroupsModule { }
