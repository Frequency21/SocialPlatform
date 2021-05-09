import { UserService } from 'src/app/services/user.service';
import { MatDialog } from '@angular/material/dialog';
import { ModalKategoryComponent } from './../modal-kategory/modal-kategory.component';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CategoryService } from 'src/app/services/category.service';
import { Category } from 'src/app/shared/models/category.model';
import { User } from 'src/app/shared/models/user.model';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {

  categories?: Category[];
  subscription: Subscription;
  currentUser?: User;

  constructor(
    private categoryService: CategoryService,
    private router: Router,
    public dialog: MatDialog,
    private userService: UserService
  ) {
    this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
  }

  ngOnInit(): void {
    this.categoryService
      .getCategories()
      .subscribe(categories => {
        console.log(categories);
        this.categories = categories;
      });
  }

  kategoriDialog(){
    const dialogRef = this.dialog.open(ModalKategoryComponent, {
      width: '40%'
    });

    dialogRef.afterClosed().subscribe(result => {
      // console.log('The dialog was closed');
    });

  }

}
