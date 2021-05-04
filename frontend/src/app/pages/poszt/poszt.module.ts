import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PosztComponent } from './poszt.component';
import {MatCardModule} from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';


@NgModule({
  declarations: [PosztComponent],
  imports: [
    CommonModule,
    MatCardModule,
    MatIconModule
  ],
  exports: [PosztComponent]
})
export class PosztModule { }
