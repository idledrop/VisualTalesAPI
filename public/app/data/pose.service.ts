import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService} from './data';

@Injectable()
export class PoseService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<IPose>) {
    _visualTalesHttp.setUrl('poses');
  }
  
  updatePose(payload:any):Observable<IPose>{
    return this._visualTalesHttp.update(payload);
  }
  
  deletePose(id:number):Observable<{}>{
    return this._visualTalesHttp.delete(id);
  }
}

export interface IPose{
  id?:number;
  name:string;
}