<nav class="navbar navbar-top navbar-expand bg-danger navbar-dark border-bottom">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav align-items-center  ml-md-auto ">
                <li class="nav-item d-sm-none">
                    <a class="nav-link text-default" href="/">
                        <i class="fi fi-home"></i>
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav align-items-center  ml-auto ml-md-0 ">
                <li class="nav-item dropdown">
                    <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="media align-items-center">
                            <div class="media-body  mr-3">
                                <span class="mb-0 text-sm text-white font-weight-bold"><?php echo $this->session->userdata('name'); ?></span>
                            </div>
                        </div>
                    </a>
                    <div class="dropdown-menu  dropdown-menu-right ">
                        <a href="<?php echo base_url() ?>profile" class="dropdown-item">
                            <i class="ni ni-single-02"></i>
                            <span>Profil Saya</span>
                        </a>
                        <a href="http://localhost/Bismillah/" class="dropdown-item">
                            <i class="ni ni-align-left-2"></i>
                            <span>Menu Lainnya</span>
                        </a>
                        <a href="<?php echo base_url() ?>keluar" class="dropdown-item">
                            <i class="ni ni-bold-left"></i>
                            <span>Keluar</span>
                        </a>
                    </div>
                </li>
                <li class="nav-item d-xl-none">
                    <div class="pl-3 sidenav-toggler" data-action="sidenav-pin" data-target="#sidenav-main">
                        <div class="sidenav-toggler-inner">
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>