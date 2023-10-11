<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman komunitas</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-3 col-md-6">
                        <div class="card card-stats">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Komunitas</h5>
                                        <span class="h2 font-weight-bold mb-0"><?php echo count($komunitas) ?></span>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                                            <i class="ni ni-app"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Komunitas Kamu</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Nama Komunitas</th>
                                    <th class="text-center">Tanggal Gabung</th>
                                    <th class="text-center">Jabatan</th>
                                    <th class="text-center">Level</th>
                                    <th class="text-center">Status</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($komunitas) { ?>
                                    <?php foreach ($komunitas as $k) { ?>
                                        <tr>
                                            <td class="text-center">
                                                <a href="#" class="text-default">
                                                    <strong><?php echo $k->nama ?></strong>
                                                </a>
                                            </td>
                                            <td class="text-center"><?php echo $k->created_at ?></td>
                                            <td class="text-center"><?php echo $k->jabatan ?></td>
                                            <?php if ($k->is_admin) { ?>
                                                <td class="text-center">Administrator</td>
                                                <td class="text-center">
                                                    <?php if ($k->is_valid == 1): ?>
                                                        <span class="badge badge-success">Tervalidasi</span>
                                                    <?php else: ?>
                                                        <span class="badge badge-danger">Belum divalidasi</span>
                                                    <?php endif ?>
                                                </td>
                                                <td>
                                                    <a href="<?php echo base_url() ?>komunitas/delete/<?php echo $k->id ?>/<?php echo $k->token ?>" class="badge badge-danger">
                                                        <i class="ni ni-scissors"></i>
                                                    </a>
                                                    <a href="<?= base_url("komunitas/detail/$k->token/$k->id_anggota") ?>" class="badge badge-info">
                                                        <i class="ni ni-button-play"></i>
                                                    </a>
                                                    <?php if ($k->is_valid == 1): ?>
                                                        <a href="<?= base_url("komunitas/detail/$k->token/$k->id_anggota") ?>" class="badge badge-primary">
                                                            <i class="fas fa-plus"></i> Tambah Anggota
                                                        </a>
                                                    <?php endif ?>
                                                    
                                                </td>
                                            <?php } else { ?>
                                                <td class="text-center">Anggota</td>
                                                <td class="text-center">
                                                    <?php if ($k->is_valid == 1): ?>
                                                        <span class="badge badge-success">Tervalidasi</span>
                                                    <?php else: ?>
                                                        <span class="badge badge-danger">Belum divalidasi</span>
                                                    <?php endif ?>
                                                </td>
                                                <td>
                                                    <a href="<?= base_url("komunitas/detail/$k->token/$k->id_anggota") ?>" class="badge badge-info">
                                                        <i class="ni ni-button-play"></i>
                                                    </a>
                                                    <!-- <?php if ($k->is_valid == 1): ?>
                                                        <a href="<?= base_url("komunitas/detail/$k->token") ?>" class="badge badge-primary">
                                                            <i class="fas fa-plus"></i> Tambah Anggota
                                                        </a>
                                                    <?php endif ?> -->
                                                    
                                                </td>
                                            <?php } ?>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="5">No Data Found</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <a href="<?php echo base_url() ?>komunitas/buat" class="btn btn-sm btn-danger">Buat Komunitas +</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>