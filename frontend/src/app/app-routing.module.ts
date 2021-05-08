import { DisplayKategoryComponent } from './pages/display-kategory/display-kategory.component';
import { ChitChatComponent } from './pages/chit-chat/chit-chat.component';
import { DisplayUserComponent } from './pages/display-user/display-user.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DisplayPostsComponent } from './pages/display-posts/display-posts.component';
import { DisplayPostsModule } from './pages/display-posts/display-posts.module';
import { DisplayUsersComponent } from './pages/display-users/display-users.component';
import { DisplayGroupsComponent } from './pages/display-groups/display-groups.component';
import { RegisterComponent } from './pages/register/register.component';
import { DisplayGroupComponent } from './pages/display-group/display-group.component';
import { AuthGaurdService } from './services/auth-gaurd.service';
import { HomeComponent } from './pages/home/home.component';
import { LoginComponent } from './pages/login/login.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { FormComponent } from './pages/form/form.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', component: HomeComponent },
  { path: 'home', pathMatch: 'full', component: HomeComponent },
  { path: 'register', pathMatch: 'full', component: RegisterComponent },
  { path: 'login', pathMatch: 'full', component: LoginComponent },
  { path: 'logout', pathMatch: 'full', component: HomeComponent, canActivate:[AuthGaurdService] },
  { path: 'profile', pathMatch: 'full', component: ProfileComponent },
  // TODO: itt majd a display-t le cserélni SocialDistancing-re. :D
  { path: 'display/users', component: DisplayUsersComponent },
  { path: 'display/groups', component: DisplayGroupsComponent },
  { path: 'display/user/:id', component: DisplayUserComponent },
  { path: 'display/group/:id', component: DisplayGroupComponent },
  { path: 'display/poszts', component: DisplayPostsComponent },
  { path: 'chitChat', component: ChitChatComponent },
  { path: 'album', component: DisplayKategoryComponent},
  { path: 'test', component: FormComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { relativeLinkResolution: 'legacy' })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
