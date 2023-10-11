<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman arsip komunitas</p>
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
                        <h4 class="mb-0">Komunitas</h4>
                        <p class="mb-0 mt-0"><small>Pilih komunitas untuk melihat arsip</small></p>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Nama Komunitas</th>
                                    <th class="text-center">Jabatan</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($komunitas) { ?>
                                    <?php foreach ($komunitas as $k) { ?>
                                        <tr>
                                            <td class="text-center">
                                                <a href="<?= base_url("arsip/detail/$k->token/$k->id_anggota") ?>" class="text-default">
                                                    <strong><?php echo $k->nama ?></strong>
                                                </a>
                                            </td>
                                            <td class="text-center"><?php echo $k->jabatan ?></td>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="2">No Data Found</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <a href="<?php echo base_url() ?>" class="btn btn-sm btn-danger">Back To Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>